import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/helper/auth_helper.dart';
import 'package:newbug/core/im/cv_im.dart';
import 'package:newbug/core/network/model/base_response.dart';
import 'package:newbug/core/network/net/net_code.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/index.dart';

class BaseResponseInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    if (ConnectivityResult.none == result.single) {
      handler.reject(
        DioException(requestOptions: options, error: T.networkError.tr),
      );
      return;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    switch (baseResponse.code) {
      case HttpCode.logout:

        ///launch 的 refreshToken 不能用reject，会走到error 处理
        toLogout(msg: baseResponse.msg);
        return;
      case HttpCode.tokenInvalid:
        handTokenError(handler, response);
        return;
    }

    super.onResponse(response, handler);
  }

  ///退出登录
  void toLogout({String? msg}) {
    CvIM.logout();
    AuthHelper.instance.toHandleLogout();
    RouteManager.offAllToLogin();
    CustomToast.dismiss().then((_) {
      CustomToast.showText(msg ?? "Failed");
    });
  }

  ///处理token error
  void handTokenError(ResponseInterceptorHandler handler, Response response) {
    handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        error: T.tokenExpired.tr,
      ),
    );
  }
}
