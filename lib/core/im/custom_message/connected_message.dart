import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///建联消息
class ConnectedMessage extends RCIMIWUserCustomMessage {
  ConnectedMessage(super.type, super.targetId);

  String? content;
  //模型化之后的数据
  ConnectModel? data;

  ConnectedMessage.fromJson(super.json) : super.fromJson();

  @override
  void decode(String jsonStr) {
    Map<String, dynamic>? map = jsonDecode(jsonStr);
    content = map?['content'];
    if (content != null && content!.isNotEmpty) {
      try {
        data = ConnectModel.fromJson(jsonDecode(content!));
      } catch (e) {
        // Handle the exception
        debugPrint("ConnectMessage decode error: $e");
      }
    }
  }

  @override
  String encode() => jsonEncode({'content': content});

  @override
  String messageObjectName() => CustomMessageType.connected.name;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json['content'] = encode();
    return json;
  }
}

class ConnectModel {
  String? title;
  String? desc;
  String? headimg;
  List<String>? desires;
  String? name;
  List<MediaListItem>? mediaList;

  ConnectModel({
    this.title,
    this.desc,
    this.headimg,
    this.desires,
    this.name,
    this.mediaList,
  });

  ConnectModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    headimg = json['headimg'];
    desires = json['desires']?.cast<String>();
    name = json['name'];
    if (json['media_list'] != null) {
      mediaList = <MediaListItem>[];
      json['media_list'].forEach((v) {
        mediaList!.add(MediaListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['headimg'] = headimg;
    data['name'] = name;
    data['desires'] = desires;
    if (mediaList != null) {
      data['media_list'] = mediaList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get isVideoEmpty => (mediaList ?? []).where((e) => e.type == 1).isEmpty;

  String? get videoUrl => (mediaList ?? []).where((e) => e.type == 1).first.url;

  bool get isImageEmpty => (mediaList ?? []).where((e) => e.type == 0).isEmpty;

  String? get imageUrl => (mediaList ?? []).where((e) => e.type == 0).first.url;
}
