import 'dart:convert' as json_lib show json;

import 'package:flutter/material.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///公开消息
class PublicMessage extends RCIMIWUserCustomMessage {
  PublicMessage(super.type, super.targetId, this.content);

  String? content;

  MediaListItem? data;

  PublicMessage.fromJson(super.json) : super.fromJson();

  @override
  void decode(String jsonStr) {
    Map<String, dynamic>? map = json_lib.json.decode(jsonStr);
    content = map?['content'];
    if (content != null && content!.isNotEmpty) {
      try {
        data = MediaListItem.fromJson(json_lib.json.decode(content!));
      } catch (e) {
        // Handle the exception
        debugPrint("PublicMessage decode error: $e");
      }
    }
  }

  @override
  String encode() => json_lib.json.encode({'content': content});

  @override
  String messageObjectName() => CustomMessageType.public.name;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json['content'] = encode();
    return json;
  }

  String conversationDigest() {
    if (data?.type == 0) {
      return '[Public photo]';
    } else if (data?.type == 1) {
      return '[Public video]';
    }
    return '[Public Message]';
  }
}
