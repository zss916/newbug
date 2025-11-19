import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newbug/core/network/model/upload_entity.dart';
import 'package:newbug/core/network/reopsitory/profile.dart';
import 'package:newbug/core/network/reopsitory/system.dart';
import 'package:newbug/core/network/utils/http_utils.dart';

mixin UploadFileMixin<T extends StatefulWidget> on State<T> {
  ///上传文件
  Future<String?> toUpload({required File file}) async {
    UploadEntity? entity = await SystemAPI.upLoadUrl(file);
    String? url = await HttpTools.upload(
      path: entity?.uploadUrl ?? "",
      file: file,
      url: entity?.cdnUrl ?? "",
    );
    return url;
  }

  ///加入到
  Future<num?> addPrivate({
    required int type,
    required String url,
    int? duration,
  }) async {
    return await ProfileAPI.addPrivateImage(
      type: type,
      url: url,
      duration: duration,
    );
  }
}
