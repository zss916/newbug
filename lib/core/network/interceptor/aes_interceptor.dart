import 'package:dio/dio.dart';
import 'package:newbug/core/network/utils/aes_utils.dart';

class AesInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var value =
        response.headers.value("X-Encrypted") ??
        response.headers.value("x-encrypted");
    if (value == "true") {
      response.data = AESUtils.decode(response.data);
    }
    super.onResponse(response, handler);
  }
}
