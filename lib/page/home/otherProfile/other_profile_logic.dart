import 'package:get/get.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/reopsitory/home.dart';
import 'package:newbug/core/widget/index.dart';

class OtherProfileLogic extends GetxController {
  String? uid;

  UserEntity? value;
  List<MediaListItem> get mediaList => value?.mediaList ?? [];

  bool loading = true;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      uid = map["uid"] as String?;
      loading = true;
    }
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  Future<void> loadData() async {
    CustomToast.loading();
    value = await HomeAPI.otherProfile(
      userId: uid,
    ).whenComplete(() => CustomToast.dismiss());
    loading = value == null;
    update();
  }
}
