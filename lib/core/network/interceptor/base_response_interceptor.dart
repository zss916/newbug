import 'package:dio/dio.dart';
import 'package:newbug/core/network/model/base_response.dart';

///不去壳，json 统一变成 BaseResponse 处理
class BaseResponseInterceptor extends Interceptor {
  BaseResponseInterceptor();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // response.data = BaseResponse.fromJson(response.data).data;
    response.data = BaseResponse.fromJson(response.data);
    handler.resolve(response);
  }
}
