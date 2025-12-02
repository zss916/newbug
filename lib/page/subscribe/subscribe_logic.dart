import 'package:get/get.dart';
import 'package:newbug/core/emums/app_emums.dart';
import 'package:newbug/core/network/model/pay_entity.dart';
import 'package:newbug/core/purchase/product_storage_utils.dart';

class SubscribeLogic extends GetxController {
  PayEntity? payData;

  @override
  void onReady() {
    super.onReady();
    loadData(PayEmu.vip);
  }

  Future<void> loadData(PayEmu type) async {
    PayEntity? value = await ProductStorageUtils.loadProductData(payType: type);
    if (value != null) {
      payData = value;
      update();
    }
  }
}
