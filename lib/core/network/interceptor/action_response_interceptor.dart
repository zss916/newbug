import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newbug/core/route/action_router.dart';
import 'package:newbug/core/widget/index.dart';

class ActionResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var action = response.data["action"];
    if (action != null && action is Map<String, dynamic>) {
      CustomToast.dismiss();
      Get.handAction(action);
    }
    super.onResponse(response, handler);
  }
}
