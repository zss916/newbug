import 'package:get/get.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';
import 'package:newbug/core/network/reopsitory/home.dart';
import 'package:newbug/core/widget/index.dart';

class FlashChatLogic extends GetxController {
  HomeCardsMatchList? value;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      value = map["match"] as HomeCardsMatchList;
      update();
    }
  }

  ///打招呼
  Future<bool> toSayHi({String? msg}) async {
    if (value?.userId != null) {
      if (msg == null) {
        // CustomToast.showText("Play Say something");
        return Future.value(false);
      }
      CustomToast.loading();
      bool isSuccessful = await HomeAPI.flashChat(
        userId: value!.userId!,
        from: 1,
        msg: msg ?? "",
      ).whenComplete(() => CustomToast.dismiss());
      return isSuccessful;
    } else {
      return Future.value(false);
    }
  }
}
