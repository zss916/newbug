import 'package:get/get.dart';
import 'package:newbug/core/network/model/unread_data_entity.dart';
import 'package:newbug/core/network/reopsitory/chat.dart';
import 'package:newbug/core/purchase/product_storage_utils.dart';
import 'package:newbug/page/location/location_utils.dart';

class MainLogic extends GetxController {
  int wlmNewNum = 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    LocationUtils.toLocation();
    loadWlmOrVisitorCount();

    ///预加载商品数据
    ProductStorageUtils.preloadVipPurchaseDataToStore();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///获取Wlm红点
  Future<void> loadWlmOrVisitorCount() async {
    UnreadDataEntity? value = await ChatAPI.queryWlmOrVisitorCount();
    wlmNewNum = (value?.wlmNewNum ?? 0);
    update();
  }
}
