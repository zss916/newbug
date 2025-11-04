import 'package:get/get.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';

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
}
