import 'dart:async';

import 'package:get/get.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/stores/event.dart';

class EditLogic extends GetxController {
  UserEntity? user;
  List<String> get tags => user?.tags ?? [];
  String get nickName => user?.nickName ?? "N/A";
  String get gender => user?.toGender ?? "N/A";
  String get birthday => user?.showBirthday ?? "N/A";
  String get sexual => user?.toSexual ?? "N/A";
  String get sign => user?.sign ?? "";

  StreamSubscription<RefreshUserEvent>? refreshUserSubs;

  @override
  void onClose() {
    super.onClose();
    refreshUserSubs?.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      user = map["user"] as UserEntity?;
    }
    refreshUserSubs = EventService.to.listen<RefreshUserEvent>((event) {
      user = event.user;
      update();
    });
  }
}
