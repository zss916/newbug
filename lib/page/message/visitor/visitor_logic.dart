import 'package:get/get.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/network/reopsitory/profile.dart';

class VisitorLogic extends GetxController {
  List<PeopleEntity> data = [];

  ///common 0, empty 1, lockList 2, loading 3
  int visitorViewState = 3;
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
    final (bool isSuccessful, List<PeopleEntity> value) =
        await ProfileAPI.getVisitorList();
    if (isSuccessful) {
      data.assignAll(value);
    }
    visitorViewState = value.isEmpty ? 1 : 2;
    update();
  }
}
