import 'package:get/get.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/network/reopsitory/profile.dart';
import 'package:newbug/core/widget/index.dart';

class VisitorLogic extends GetxController {
  List<PeopleEntity> data = [];

  int viewState = 2;
  bool isUserVip = false;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
    isUserVip = map["isUserVip"];
    update();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  ///加载数据
  Future<void> loadData() async {
    CustomToast.loading();
    final (
      bool isSuccessful,
      List<PeopleEntity> value,
    ) = await ProfileAPI.getVisitorList().whenComplete(
      () => CustomToast.dismiss(),
    );
    if (isSuccessful) {
      data = value;
      update();
    }
  }
}
