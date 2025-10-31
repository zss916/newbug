import 'dart:io';

import 'package:http/http.dart' as httputils;

class HttpTools {
  /// 上传文件
  static Future<String?> upload({
    required String path,
    required File file,
    required String url,
  }) async {
    var response = await httputils.put(
      Uri.parse(path),
      headers: {
        'Accept': "*/*",
        'Content-Length': file.lengthSync().toString(),
        'Connection': 'keep-alive',
      },
      body: file.readAsBytesSync(),
    );
    if (response.statusCode == 200) {
      return url;
    } else {
      return null;
    }
  }
}
