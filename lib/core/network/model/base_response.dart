import 'dart:convert';

import 'package:newbug/core/widget/index.dart';

class BaseResponse<T> {
  int? code;
  String? msg;
  T? data;

  BaseResponse(this.code, this.msg, this.data);

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse<T>(
    json['code'] as int?,
    json['msg'] as String?,
    json['data'] as T?,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['code'] = code;
    result['msg'] = msg;
    result['data'] = data;
    return result;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  /// 判断请求是否成功
  bool get isSuccessful => code == 0;

  /// 请求失败的错误信息
  String get errorMsg => (msg ?? "").isNotEmpty ? msg! : "Failed";

  ///失败提示
  void toFailToast({String? error}) => CustomToast.fail(error ?? errorMsg);

  ///成功提示
  void toSuccessToast({String? msg}) =>
      CustomToast.success(msg ?? 'Successful');

  /// 通用提示
  void toCommonToast({required String msg}) => CustomToast.text(msg);
}
