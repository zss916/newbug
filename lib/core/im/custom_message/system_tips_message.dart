import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///系统提示消息
class SystemTipsMessage extends RCIMIWUserCustomMessage {
  SystemTipsMessage(super.type, super.targetId);

  String? content;

  SystemTipsModel? data;

  SystemTipsMessage.fromJson(super.json) : super.fromJson();

  @override
  void decode(String jsonStr) {
    Map<String, dynamic>? map = jsonDecode(jsonStr);
    content = map?['content'];
    if (content != null && content!.isNotEmpty && map != null) {
      try {
        data = SystemTipsModel.fromJson(map);
      } catch (e) {
        // Handle the exception
        debugPrint("System tips Message decode error: $e");
      }
    }
  }

  @override
  String encode() => jsonEncode({'content': content});

  @override
  String messageObjectName() => CustomMessageType.systemTips.name;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json['content'] = encode();
    return json;
  }

  String conversationDigest() {
    return data?.content ?? "";
  }
}

class SystemTipsModel {
  String? content;

  SystemTipsModel({this.content});

  SystemTipsModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['content'] = content;
    return data;
  }
}
