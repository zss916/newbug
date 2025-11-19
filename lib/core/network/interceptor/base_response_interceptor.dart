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
      CvIM.logout();
      AuthHelper.instance.toHandleLogout();
      RouteManager.offAllToLogin();
      CustomToast.dismiss().then((_) {
        CustomToast.showText(baseResponse.msg ?? "Failed");
      });

      ///launch 的 refreshToken 不能用reject，会走到error 处理
      /* handler.reject(
        DioException(
          requestOptions: RequestOptions(),
          response: response,
          message: baseResponse.msg,
        ),
      );*/
      //handler.next(response);
    } else {
      super.onResponse(response, handler);
    }
  }
}
