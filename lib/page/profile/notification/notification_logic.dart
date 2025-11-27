part of 'index.dart';

class NotificationLogic extends GetxController {
  int _config = 0;
  bool get messagesValue => _config & (1 << 0) == 0;
  bool get matchValue => _config & (1 << 1) == 0;
  bool get likeValue => _config & (1 << 2) == 0;
  bool get visitorValue => _config & (1 << 3) == 0;

  @override
  void onInit() {
    super.onInit();
    _config = AppStores.getPushConfig();
  }

  Future<void> setPushConfig(int index) async {
    _config ^= (1 << index);
    CustomToast.loading();
    bool isSuccessful = await ProfileAPI.notifyUpdate(
      config: _config,
    ).whenComplete(() => CustomToast.dismiss());
    if (isSuccessful) {
      AppStores.setPushConfig(config: _config);
      update();
    }
  }
}
