import 'package:get/get.dart';
import 'package:newbug/core/emums/app_emums.dart';
import 'package:newbug/core/network/model/pay_entity.dart';
import 'package:newbug/core/network/reopsitory/pay.dart';

class SubscribeLogic extends GetxController {
  @override
  void onReady() {
    super.onReady();
    loadData(PayEmu.vip);
  }

  Future<void> loadData(PayEmu type) async {
    PayEntity? value = await PayAPI.getProductList(type: type.index);
    if (value != null) {
      List<PayShops> shops = value.shops ?? [];
      if (type == PayEmu.privateVideo || type == PayEmu.privatePhoto) {
        ///按照时间排序
        shops.sort((a, b) {
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
        value.shops = shops;
      }
      for (var i = 0; i < shops.length; i++) {
        final ele = shops[i];
        if (ele.prodId != null) {
          ///更正价格
          _getRealPriceFromAppStore(type, ele.prodId ?? "");
        }
      }

      ///todo 保存vip 数据到本地
    }
  }

  static Future<void> _getRealPriceFromAppStore(
    PayEmu payType,
    String productId,
  ) async {
    /*final productItem = await PurchaseTools.instance.getRealPriceItem(
      productId,
    );*/
    //final realPrice = productItem?.price;
    // if (realPrice != null) {}
  }
}
