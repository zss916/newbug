import 'package:get/get.dart';
import 'package:newbug/core/helper/auth_helper.dart';
import 'package:newbug/core/network/reopsitory/account.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/index.dart';

class DeleteAccountLogic extends GetxController {
  Future<void> toDeleteAccount() async {
    CustomToast.loading();
    bool isSuccessful = await AccountAPI.deleteAccount().whenComplete(
      () => CustomToast.dismiss(),
    );
    if (isSuccessful) {
      AuthHelper.instance.toHandleDeleteAccount();
      RouteManager.offAllToLogin();
    }
  }
}
