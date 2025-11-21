import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///私密消息
class PrivateMessage extends RCIMIWUserCustomMessage {
  PrivateMessage(super.type, super.targetId, this.content);

  String? content;
  MediaListItem? data;

  PrivateMessage.fromJson(super.json) : super.fromJson();

  @override
  void decode(String jsonStr) {
    Map<String, dynamic>? map = json.decode(jsonStr);
    content = map?['content'];
    if (content != null && content!.isNotEmpty) {
      try {
        data = MediaListItem.fromJson(json.decode(content!));
      } catch (e) {
        // Handle the exception
        debugPrint("PrivacyMessage decode error: $e");
      }
    }
  }

  @override
  String encode() => json.encode({'content': content});

  @override
  String messageObjectName() => CustomMessageType.private.name;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json['content'] = encode();
    return json;
  }

  String conversationDigest() {
    if (data?.type == 0) {
      return '[Private photo]';
    } else if (data?.type == 1) {
      return '[Private video]';
    }
    return '[Privacy Message]';
  }

  /// 是否是未解锁状态
  bool isUnlockStatus() {
    if (expansion != null && expansion?.isNotEmpty == true) {
      PrivacyExtraData extraData = PrivacyExtraData.fromJson(expansion!);
      if (extraData.status == "0") {
        return true;
      } else if (extraData.status == "1") {
        return false;
      } else if (extraData.status == "2") {
        return false;
      }
      return true;
    }
    return true;
  }

  ///是否销毁
  bool isDestroyedStatus() {
    if (expansion != null && expansion?.isNotEmpty == true) {
      PrivacyExtraData extraData = PrivacyExtraData.fromJson(expansion!);
      if (extraData.status == "0") {
        return false;
      } else if (extraData.status == "1") {
        return false;
      } else if (extraData.status == "2") {
        return true;
      }
      return false;
    }
    return false;
  }
}

class PrivacyExtraData {
  /// 0或者无表示私密消息未打开，1已经打开 2已经被销毁
  String? status;
  String? del_time;
  //是否手动刷新融云扩展信息 0不手动 1手动
  int? setExt;

  PrivacyExtraData({this.status = "0", this.del_time = "0", this.setExt});

  factory PrivacyExtraData.fromJson(Map json) {
    return PrivacyExtraData(
      status: json['status'] as String?,
      del_time: json['del_time'] as String?,
      setExt: json['set_ext'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'del_time': del_time, 'set_ext': setExt};
  }
}
