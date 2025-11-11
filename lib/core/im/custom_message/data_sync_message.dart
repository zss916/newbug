import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///消息同步数据
class DataSyncMessage extends RCIMIWUserCustomMessage {
  DataSyncMessage(super.type, super.targetId);

  String? content;

  MessageEventData? data;

  DataSyncMessage.fromJson(super.json) : super.fromJson();

  @override
  void decode(String jsonStr) {
    Map<String, dynamic>? map = jsonDecode(jsonStr);
    content = map?['content'];
    if (content != null && content!.isNotEmpty) {
      try {
        data = MessageEventData.fromJson(jsonDecode(content!));
      } catch (e) {
        // Handle the exception
        debugPrint("EventMessage decode error: $e");
      }
    }
  }

  @override
  String encode() => jsonEncode({'content': content});

  @override
  String messageObjectName() => CustomMessageType.sync.name;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json['content'] = encode();
    return json;
  }
}

class MessageEventData {
  String event;
  Map<String, dynamic>? data;

  MessageEventData({required this.event, this.data});

  factory MessageEventData.fromJson(Map<String, dynamic> json) {
    return MessageEventData(
      event: json['event'] as String,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'event': event};
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}

class EventOnlineData {
  List<String> im_uids;
  int online; //1上线

  EventOnlineData({required this.im_uids, required this.online});

  factory EventOnlineData.fromJson(Map<String, dynamic> json) {
    return EventOnlineData(
      im_uids: (json['im_uids'] as List<dynamic>).cast<String>(),
      online: json['online'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'im_uids': im_uids, 'online': online};
  }
}

class EventOnlineListData {
  List<String> uIds;

  EventOnlineListData({required this.uIds});

  factory EventOnlineListData.fromJson(Map<String, dynamic> json) {
    return EventOnlineListData(
      uIds: (json['uIds'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'uIds': uIds};
  }
}

class EventLvlData {
  String im_uid;
  int? chat_num;

  EventLvlData({required this.im_uid, this.chat_num});

  factory EventLvlData.fromJson(Map<String, dynamic> json) {
    return EventLvlData(
      im_uid: json['im_uid'] as String,
      chat_num: json['chat_num'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'im_uid': im_uid, 'chat_num': chat_num};
  }
}

class EventBindData {
  List<String> modelids;
  int bind;

  EventBindData({required this.modelids, required this.bind});

  factory EventBindData.fromJson(Map<String, dynamic> json) {
    return EventBindData(
      modelids: (json['modelids'] as List<dynamic>).cast<String>(),
      bind: json['bind'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'modelids': modelids, 'bind': bind};
  }
}
