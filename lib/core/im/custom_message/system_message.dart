import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:newbug/core/im/custom_message/model/user_info_model.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///系统触发的行为消息
class SystemMessage extends RCIMIWUserCustomMessage {
  SystemMessage(super.type, super.targetId);

  String? content;

  SystemPushModel? data;

  SystemMessage.fromJson(super.json) : super.fromJson();

  @override
  void decode(String jsonStr) {
    Map<String, dynamic>? map = jsonDecode(jsonStr);
    content = map?['content'];
    if (content != null && content!.isNotEmpty) {
      try {
        data = SystemPushModel.fromJson(jsonDecode(content!));
      } catch (e) {
        // Handle the exception
        debugPrint("SystemMessage decode error: $e");
      }
    }
  }

  @override
  String encode() => jsonEncode({'content': content});

  @override
  String messageObjectName() => CustomMessageType.system.name;

  String conversationDigest() {
    return data?.msg ?? "";
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    // 此处 'content' 不可修改
    json['content'] = encode();
    return json;
  }
}

class SystemPushModel extends UserInfoModel {
  Map<String, dynamic>? action;
  String? msg;

  ///1 wlm 2cupid 3 match 4visitor 5new match横幅
  int? pushType;

  SystemPushModel({this.action, this.msg, this.pushType});

  SystemPushModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    action = json['action'];
    msg = json['msg'];
    pushType = json['push_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['action'] = action;
    data['msg'] = msg;
    data['push_type'] = pushType;
    return data;
  }
}
