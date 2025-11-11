part of 'index.dart';

class ChatLogic extends GetxController {
  String? targetId;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map<String, dynamic> map = Get.arguments as Map<String, dynamic>;
      targetId = map["targetId"];
    }
  }

  ///发送消息
  void toSend({required String value}) {
    debugPrint("uid => ${AppStores.getUid()}");
    if ((targetId ?? '').isNotEmpty) {
      CvIM.toSend(targetId: targetId ?? "", text: value);
    } else {
      debugPrint("targetId is null");
    }
  }

  void dd() {
    ///todo
    CvIM.toSend(
      targetId: "10011056",
      text: "meiy 55 ",
      onSendResult: (value) {
        //logic.loadAllConversations();
      },
    );
  }
}
