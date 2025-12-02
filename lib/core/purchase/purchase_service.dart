import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart'
    as android_purchase;

class PurchaseService extends GetxService {
  static PurchaseService get to => Get.find();

  /*PurchaseTools._();

  static final PurchaseTools _instance = PurchaseTools._();

  static PurchaseTools get instance => _instance;*/

  final InAppPurchase _iap = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool _isRequestionRestore = false;

  @override
  void onInit() {
    super.onInit();
    initialize();
    _HandrestorePurchases();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  ///监听订单状态
  Future<void> initialize() async {
    if (!(await _iap.isAvailable())) return;
    _subscription = _iap.purchaseStream.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (error) {
        debugPrint("listen :$error");
      },
    );
  }

  /// 请求之前的restore订单 _invokeCheckOrder
  void _HandrestorePurchases() async {
    if (_isRequestionRestore) return;
    _isRequestionRestore = true;
    try {
      ///获取本地存储的订单
      ///变成PurchaseDetails()
      ///点用验单_invokeCheckOrder

      //final preStorageOrders = PayStorageManager.getPreStoragePlayOrders();
      // LogUtils.d("之前需要完成的订单: ${preStorageOrders.toString()}");
      /* for (PayStorageOrder order in preStorageOrders) {
        final orderInfo = order.orderInfo;
        if (orderInfo?.productID != null) {
          PurchaseDetails purchaseDetails = PurchaseDetails(
            productID: orderInfo?.purchaseID ?? "",
            verificationData: PurchaseVerificationData(
              localVerificationData:
              orderInfo?.verificationData?.localVerificationData ?? "",
              serverVerificationData:
              orderInfo?.verificationData?.serverVerificationData ?? "",
              source: orderInfo?.verificationData?.source ?? "",
            ),
            transactionDate: orderInfo?.transactionDate,
            status: orderInfo?.status ?? PurchaseStatus.purchased,
          );
          await _invokeCheckOrder(purchaseDetails);
        }
      }*/

      ///恢复购买
      await _restorePurchases();
    } catch (error) {
      debugPrint("restore purchase error: $error");
    }
    _isRequestionRestore = false;
  }

  /// 监听购买更新
  Future<void> _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    if (purchaseDetailsList.isEmpty) return;

    ///遍历获取每一个商品信息状态
    _handLoopPurchaseDetails(purchaseDetailsList);

    ///筛选出商品信息(恢复商品信息)
    final filteredList = purchaseDetailsList
        .where((purchase) => purchase.status == PurchaseStatus.restored)
        .toList();
    if (filteredList.isEmpty) return;

    ///遍历调用校验订单
    for (PurchaseDetails value in purchaseDetailsList) {
      _invokeCheckOrder(value);
    }
  }

  void _handLoopPurchaseDetails(List<PurchaseDetails> purchaseDetailsList) {
    for (int i = 0; i < purchaseDetailsList.length; i++) {
      PurchaseDetails purchaseDetails = purchaseDetailsList[i];
      PurchaseStatus purchaseStatus = purchaseDetails.status;
      switch (purchaseStatus) {
        case PurchaseStatus.purchased:
          //购买成功
          debugPrint("purchase purchased: ${purchaseDetails.purchaseID}");
          //  InAppPurchase.instance.completePurchase(purchase);
          break;
        case PurchaseStatus.error:
          //购买失败
          debugPrint(
            "purchase error: ${purchaseDetails.purchaseID}，error: ${purchaseDetails.error}",
          );
          break;
        case PurchaseStatus.pending:
          // 用户还在支付确认中
          debugPrint("purchase pending: ${purchaseDetails.purchaseID}");
          break;
        case PurchaseStatus.restored:
          //恢复购买
          debugPrint("purchase restored: ${purchaseDetails.purchaseID}");
          //  InAppPurchase.instance.completePurchase(purchase);
          break;
        case PurchaseStatus.canceled:
          //用户取消
          debugPrint("purchase canceled: ${purchaseDetails.purchaseID}");
          break;
      }
    }
  }

  ///检验订单
  Future<void> _invokeCheckOrder(PurchaseDetails? purchaseDetails) async {
    // 没有购买对象，就没法校验订单
    if (purchaseDetails == null) return;

    ///todo 没有登录就不能校验订单
    ///消耗订单
    await _consumePurchase(purchaseDetails);

    ///完成订单
    await _completePurchase(purchaseDetails);
  }

  ///消耗订单(Android)
  Future<bool> _consumePurchase(PurchaseDetails purchaseDetails) async {
    if (Platform.isAndroid) {
      try {
        android_purchase.InAppPurchaseAndroidPlatformAddition androidAddition =
            InAppPurchase.instance
                .getPlatformAddition<
                  android_purchase.InAppPurchaseAndroidPlatformAddition
                >();
        BillingResultWrapper billingResult = await androidAddition
            .consumePurchase(purchaseDetails);
        return billingResult.responseCode == BillingResponse.ok;
      } catch (e) {
        debugPrint("消耗订单失败：$e");
        return false;
      }
    } else {
      return false;
    }
  }

  ///完成订单
  Future<void> _completePurchase(PurchaseDetails purchaseDetail) async {
    if (purchaseDetail.pendingCompletePurchase) {
      await _iap.completePurchase(purchaseDetail).then((value) {
        if (purchaseDetail.status == PurchaseStatus.purchased) {
          /// 购买成功
        }
      });
    }
  }

  ///恢复购买的商品或者订阅状态
  Future<void> _restorePurchases() async {
    try {
      await _iap.restorePurchases();
    } catch (e) {
      debugPrint("恢复失败");
    }
  }

  /// 判断是否为订阅商品（Android平台才有）
  bool _isSubscription(String productID) {
    return productID.toLowerCase().contains("week") ||
        productID.toLowerCase().contains("month") ||
        productID.toLowerCase().contains("quarter");
  }

  /// 购买商品(订阅商品)
  Future<void> _buyProductById(String productId) async {
    try {
      ///通过商品ID (如：com.yourcompany.app.iap_item_001)查询商品
      final ProductDetailsResponse response = await _iap.queryProductDetails({
        productId,
      });

      if (response.notFoundIDs.isNotEmpty || response.productDetails.isEmpty) {
        debugPrint('商品没有找到');
        return;
      }

      ///获取查询到商品
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: response.productDetails.first,
      );

      //3. 购买商品
      if (_isSubscription(productId)) {
        ///购买订阅商品(买一次)
        await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      } else {
        ///购买消耗性商品(买多次)
        await _iap.buyConsumable(
          purchaseParam: purchaseParam,
          autoConsume: true,
        );
      }
    } catch (e) {
      debugPrint('购买失败:$e');
    }
  }

  /// 缓存每一个商品的store detail
  final Map<String, ProductDetails> _productDetailsMapFromStore = {};

  ///从商店获取线上的商品信息
  Future<ProductDetails?> getProductDetailsFromStore(String productId) async {
    ProductDetails? details = _productDetailsMapFromStore[productId];
    if (details != null) {
      return details;
    }
    final ProductDetailsResponse productDetailsResponse = await _iap
        .queryProductDetails({productId});
    for (ProductDetails details in productDetailsResponse.productDetails) {
      _productDetailsMapFromStore[details.id] = details;
    }
    details = _productDetailsMapFromStore[productId];
    return details;
  }
}
