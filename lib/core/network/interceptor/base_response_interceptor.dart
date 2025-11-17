import 'package:dio/dio.dart';
import 'package:newbug/core/helper/auth_helper.dart';
import 'package:newbug/core/im/cv_im.dart';
import 'package:newbug/core/network/model/base_response.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/index.dart';

class BaseResponseInterceptor extends Interceptor {
  BaseResponseInterceptor();
  int tokenError = 1002;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    if (baseResponse.code == tokenError) {
      if ((baseResponse.msg ?? "").isNotEmpty) {
        CustomToast.showText(baseResponse.msg ?? "");
      }
      CvIM.logout();
      AuthHelper.instance.toHandleLogout();
      RouteManager.offAllToLogin();
      handler.next(response);
    } else {
      super.onResponse(response, handler);
    }
  }
}
