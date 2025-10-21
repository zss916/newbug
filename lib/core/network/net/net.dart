import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:newbug/core/network/interceptor/header_interceptor.dart';

class Net {
  static final Net _instance = Net._internal();
  static Net get instance => Net();
  factory Net() => _instance;

  late Dio _dio;

  Net._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );
    _dio.httpClientAdapter = IOHttpClientAdapter(
      validateCertificate: (cert, host, port) {
        return true;
      },
    );

    //_dio.interceptors.add(NetWorkInterceptor());

    /// 代理抓包
    //_dio.httpClientAdapter = ProxyTool.getProxyAdapter();

    ///auth
    _dio.interceptors.add(HeaderInterceptor());

    /// 缓存
    // _dio.interceptors.add(cacheInterceptor);

    /// 日志
    //_dio.interceptors.add(LoggerInterceptor());
    // _dio.interceptors.add(prettyDioLogger);

    /// 错误拦截
    //_dio.interceptors.add(ErrorInterceptor());
  }

  ///更新adjustID
  void addHeaders({required String adjustID}) {
    Map<String, String> headers = {"ad-id": adjustID};
    _dio.options.headers.addAll(headers);
  }

  ///post
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    bool showToast = true,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        //options: options,
        cancelToken: cancelToken,
      );
      return response.data ?? '{}';
    } catch (error) {
      rethrow;
    }
  }

  ///get
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? query,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _dio.get(
        url,
        queryParameters: query,
        data: data,
        //options: options,
        cancelToken: cancelToken,
      );
      return result.data ?? '{}';
    } catch (error) {
      rethrow;
    }
  }

  ///delete
  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? query,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _dio.delete(
        url,
        queryParameters: query,
        data: data,
        //options: options,
        cancelToken: cancelToken,
      );
      return result.data ?? '{}';
    } catch (error) {
      rethrow;
    }
  }

  ///patch
  Future<dynamic> patch(
    String url, {
    Map<String, dynamic>? query,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _dio.patch(
        url,
        queryParameters: query,
        data: data,
        //options: options,
        cancelToken: cancelToken,
      );
      return result.data ?? '{}';
    } catch (error) {
      rethrow;
    }
  }

  ///put
  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? query,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _dio.put(
        url,
        queryParameters: query,
        data: data,
        //options: options,
        cancelToken: cancelToken,
      );
      return result.data ?? '{}';
    } catch (error) {
      rethrow;
    }
  }
}
