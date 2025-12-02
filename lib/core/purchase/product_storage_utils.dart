import 'dart:convert';

import 'package:newbug/core/emums/app_emums.dart';
import 'package:newbug/core/network/model/pay_entity.dart';
import 'package:newbug/core/network/reopsitory/pay.dart';
import 'package:newbug/core/purchase/purchase_service.dart';
import 'package:newbug/core/stores/stores_service.dart';

///商品缓存策略
class ProductStorageUtils {
  static final String _localVipKey = "user_vip_purchase_data_key";
  static final String _localPVKey = "user_pv_purchase_data_key";
  static final String _localPPKey = "user_pp_purchase_data_key";
  static final String _localFCKey = "user_fc_purchase_data_key";

  ///获取购买商品数据
  static Future<PayEntity?> loadProductData({required PayEmu payType}) async {
    PayEntity? localData = ProductStorageUtils.getVipDataFromLocal(payType);
    if (localData == null) {
      PayEntity? netData = await ProductStorageUtils.requestPurchaseTypeData(
        payType,
      );
      return netData;
    } else {
      return localData;
    }
  }

  /// 预加载VIP商品数据(登录后主页加载)
  static void preloadVipPurchaseDataToStore() {
    requestPurchaseTypeData(PayEmu.vip);
    requestPurchaseTypeData(PayEmu.privateVideo);
    requestPurchaseTypeData(PayEmu.privatePhoto);
    requestPurchaseTypeData(PayEmu.flashChat);
  }

  /// 清空购买页的缓存数据
  static void clear() {
    StoresService.to.remove(_localVipKey);
    StoresService.to.remove(_localPVKey);
    StoresService.to.remove(_localPPKey);
    StoresService.to.remove(_localFCKey);
  }

  /// 获取vip购买页的数据
  static Future<PayEntity?> requestPurchaseTypeData(PayEmu type) async {
    PayEntity? value = await PayAPI.getProductList(type: type.index);
    final productIdList = (value?.shops ?? []);

    ///按时间排序
    value?.shops = _sortProductByTime(type, productIdList);

    ///本地商品遍历更正价格
    _updateRealPriceFormAppStore(type, productIdList);

    if (value != null) {
      ///保存在本地
      _saveVipDataToLocal(value, type);
    }
    return value;
  }

  ///遍历更正价格
  static _updateRealPriceFormAppStore(
    PayEmu type,
    List<PayShops> productIdList,
  ) async {
    for (PayShops item in productIdList) {
      if (item.prodId != null) {
        String productId = item.prodId ?? "";
        final productItem = await PurchaseService.to.getProductDetailsFromStore(
          productId,
        );
        final realPrice = productItem?.price;
        if (realPrice != null) {
          ///更新到本地
          _updateProductRealPrice(type, productId, realPrice);

          ///刷新
        }
      }
    }
  }

  /// 更新某一个product的真实价格
  static void _updateProductRealPrice(
    PayEmu payType,
    String productId,
    String realPrice,
  ) {
    final payData = getVipDataFromLocal(payType);
    if (payData == null) return;
    for (var ele in (payData.shops ?? [])) {
      if (ele.prodId == productId && ele.realPrice == null) {
        ele.realPrice = realPrice;
      }
    }
    _saveVipDataToLocal(payData, payType);
  }

  /// 获取本地购买页数据
  static PayEntity? getVipDataFromLocal(PayEmu payType) {
    var localKey = "";
    switch (payType) {
      case PayEmu.vip:
        {
          localKey = _localVipKey;
          break;
        }
      case PayEmu.flashChat:
        localKey = _localFCKey;
        break;
      case PayEmu.privateVideo:
        localKey = _localPVKey;
        break;
      case PayEmu.privatePhoto:
        localKey = _localPPKey;
        break;
    }
    String localValue = StoresService.to.getString(localKey);
    if (localValue.isNotEmpty) {
      var localDataJson = jsonDecode(localValue);
      if (localDataJson != null) {
        return PayEntity.fromJson(localDataJson);
      }
    }
    return null;
  }

  ///按照时间排序
  static List<PayShops> _sortProductByTime(
    PayEmu type,
    List<PayShops> productIdList,
  ) {
    if (type == PayEmu.privateVideo || type == PayEmu.privatePhoto) {
      productIdList.sort((a, b) {
        // 将time字符串转换为整数
        try {
          int timeA = int.parse(a.time ?? "");
          int timeB = int.parse(b.time ?? "");
          // 从大到小排序（降序）
          return timeB.compareTo(timeA);
        } catch (error) {
          return 0;
        }
      });
      return productIdList;
    } else {
      return productIdList;
    }
  }

  /// 存储购买页的数据到本地
  static _saveVipDataToLocal(PayEntity? payData, PayEmu payType) {
    var localKey = "";
    switch (payType) {
      case PayEmu.vip:
        {
          localKey = _localVipKey;
          break;
        }
      case PayEmu.flashChat:
        localKey = _localFCKey;
        break;
      case PayEmu.privateVideo:
        localKey = _localPVKey;
        break;
      case PayEmu.privatePhoto:
        localKey = _localPPKey;
        break;
    }
    if (payData == null) {
      StoresService.to.remove(localKey);
    } else {
      StoresService.to.setString(localKey, jsonEncode(payData.toJson()));
    }
  }

  /// 更新ppv的商品信息.
  static void updatePurchaseDataForPpv(PayEmu? type) {
    if (type == null) return;
    if (type != PayEmu.privateVideo && type != PayEmu.privatePhoto) return;
    _removePayStorageData(PayEmu.privateVideo);
    _removePayStorageData(PayEmu.privatePhoto);
    requestPurchaseTypeData(PayEmu.privateVideo);
    requestPurchaseTypeData(PayEmu.privatePhoto);
  }

  /// 删除某一个类型的缓存数据
  static void _removePayStorageData(PayEmu payType) {
    switch (payType) {
      case PayEmu.vip:
        {
          StoresService.to.remove(_localVipKey);
          break;
        }
      case PayEmu.flashChat:
        {
          StoresService.to.remove(_localFCKey);
          break;
        }
      case PayEmu.privateVideo:
        {
          StoresService.to.remove(_localPVKey);
          break;
        }
      case PayEmu.privatePhoto:
        {
          StoresService.to.remove(_localPPKey);
          break;
        }
    }
  }
}
