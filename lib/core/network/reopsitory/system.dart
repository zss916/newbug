import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:newbug/core/network/model/config_entity.dart';
import 'package:newbug/core/network/model/upload_entity.dart';
import 'package:newbug/core/network/net/net.dart';
import 'package:newbug/core/network/path/netPath.dart';
import 'package:newbug/core/widget/index.dart';

abstract class SystemAPI {
  ///全局配置
  static Future<ConfigEntity?> config() async {
    try {
      final result = await Net.instance.post(ApiPath.globalConfig);
      if (result["code"] == 0) {
        ConfigEntity value = await compute(
          (dynamic jsonStr) => ConfigEntity.fromJson(jsonStr),
          result["data"],
        );
        return value;
      } else {
        //  CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      CustomToast.fail(error.toString());
      return null;
    }
  }

  ///上报adjust 信息
  static Future<bool> updateAdjust({Map<String, dynamic>? data}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.updateUserAction,
        queryParameters: data,
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///举报
  static Future<bool> report({
    required String userId,
    required int reportId,
    int? form,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data["user_id"] = userId;
      data["report_id"] = reportId;
      if (form != null) {
        data["from"] = form;
      }
      final result = await Net.instance.post(
        ApiPath.reportUser,
        queryParameters: data,
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///拉黑
  static Future<bool> block({required String userId, int type = 1}) async {
    try {
      Map<String, dynamic> data = {};
      data["user_id"] = userId;
      data["type"] = type;
      final result = await Net.instance.post(
        ApiPath.blockUser,
        queryParameters: data,
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///弹窗
  static Future<bool> alert({required String userId, int type = 1}) async {
    try {
      final result = await Net.instance.post(ApiPath.alert);
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///获取上传图片&视频地址
  static Future<UploadEntity?> upLoadUrl(File file) async {
    try {
      var bytes = await file.readAsBytes();
      String fileNameMd5 = md5.convert(bytes).toString();
      String fileName =
          fileNameMd5 + file.path.substring(file.path.lastIndexOf("."));
      final result = await Net.instance.post(
        ApiPath.globalUploadUrl,
        options: Options(
          headers: {
            "Connection": 'keep-alive',
            "Content-Type": "application/json",
          },
        ),
        queryParameters: {"file_name": fileName},
      );

      if (result["code"] == 0) {
        UploadEntity value = await compute(
          (dynamic jsonStr) => UploadEntity.fromJson(jsonStr),
          result["data"],
        );
        return value;
      } else {
        CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  /// 更新推送token
  static Future<bool> updatePushToken({required String pushToken}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.updatePushToken,
        queryParameters: {"push_token": pushToken},
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }

  ///pushTrace
}
