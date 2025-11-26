import 'package:get/get.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/reopsitory/home.dart';

class OtherProfileLogic extends GetxController {
  String? uid;

  UserEntity? value;
  List<MediaListItem> get mediaList => value?.mediaList ?? [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      uid = map["uid"] as String?;
    }
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  Future<void> loadData() async {
    value = await HomeAPI.otherProfile(userId: uid);
    update();
  }
}
