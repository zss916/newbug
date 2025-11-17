import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:newbug/core/config/constants.dart';
import 'package:newbug/core/network/interceptor/aes_interceptor.dart';
import 'package:newbug/core/network/interceptor/base_response_interceptor.dart';
import 'package:newbug/core/network/interceptor/header_interceptor.dart';
import 'package:newbug/core/network/path/netPath.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Net {
  static final Net _instance = Net._internal();
  static Net get instance => Net();
  factory Net() => _instance;

  late Dio _dio;

  Net._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiPath.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        persistentConnection: true,
        headers: {
          "Accept-Encoding": "gzip",
          // "Connection": "keep-alive",
          // "Content-Type": "application/json",
          "platfrom": "android",
          "app-src": "googleplay",
          /*  "Authorization":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NjM4OTA2ODAsImlhdCI6MTc2MTIxMjI4MCwicGxhdCI6MSwidXNlcklkIjoxMDAxMTAzMX0.HgWQSkk2XHbBkY1CnPo86zuM-To9tYALDmo-m4GFaHU",*/
        },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );
    _dio.httpClientAdapter = IOHttpClientAdapter(
      validateCertificate: (cert, host, port) {
        return true;
      },
    );

    /// 代理抓包
    //_dio.httpClientAdapter = ProxyTool.getProxyAdapter();

    ///auth
    _dio.interceptors.add(HeaderInterceptor());

    ///解码
    if (App.isHttpEncrypt) {
      _dio.interceptors.add(AesInterceptor());
    }

    ///返回值处理
    _dio.interceptors.add(BaseResponseInterceptor());

    /// 缓存
    // _dio.interceptors.add(cacheInterceptor);

    /// 日志
    //_dio.interceptors.add(LoggerInterceptor());

    /// 错误拦截
    //_dio.interceptors.add(ErrorInterceptor());

    /// 日志
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ),
    );
  }

  ///更新adjustID
  void addHeaders({required String adjustID}) {
    Map<String, String> headers = {"ad-id": adjustID};
    _dio.options.headers.addAll(headers);
  }

  ///更新token
  void updateHeaders({required String token}) {
    Map<String, String> headers = {"Authorization": token};
    _dio.options.headers.addAll(headers);
  }

  ///post
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
      );

      return response.data ?? '{}';
    } catch (error) {
      rethrow;
    }
  }
}
