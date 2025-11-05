import 'package:get/get.dart';
import 'package:newbug/core/network/model/unread_data_entity.dart';
import 'package:newbug/core/network/reopsitory/chat.dart';
import 'package:newbug/page/location/location_utils.dart';

class MainLogic extends GetxController {
  int tabIndex = 0;
  bool showReadMark = false;

  @override
  void onReady() {
    super.onReady();
    LocationUtils.toLocation();
    loadWlmOrVisitorCount();
  }

  ///获取红点
  Future<void> loadWlmOrVisitorCount() async {
    UnreadDataEntity? value = await ChatAPI.queryWlmOrVisitorCount();
    showReadMark = (value?.wlmNewNum ?? 0) > 0;
    update();
  }
}
