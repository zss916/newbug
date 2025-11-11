import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///多张私密打包消息
class PrivatePackageMessage extends RCIMIWUserCustomMessage {
  PrivatePackageMessage(super.type, super.targetId, this.content);

  String? content;

  PackageMediaModel? data;

  PrivatePackageMessage.fromJson(super.json) : super.fromJson();

  @override
  void decode(String jsonStr) {
    Map<String, dynamic>? map = jsonDecode(jsonStr);
    content = map?['content'];
    if (content != null && content!.isNotEmpty) {
      try {
        data = PackageMediaModel.fromJson(jsonDecode(content!));
      } catch (e) {
        // Handle the exception
        debugPrint("PackagePrivacyMessage decode error: $e");
      }
    }
  }

  @override
  String encode() => jsonEncode({'content': content});

  @override
  String messageObjectName() => CustomMessageType.packagePrivate.name;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json['content'] = encode();
    return json;
  }

  String conversationDigest() {
    if (data?.type == 0) {
      return '[${data?.num} Private photos]';
    } else if (data?.type == 1) {
      return '[${data?.num} Private videos]';
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
    } else {
      //未解锁状态
      return true;
    }
  }

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

class PackageMediaModel {
  String original_msgid;
  List<PackageMediaItem> list;
  String media_ids;
  //0图片 1视频
  int type;
  int num;

  PackageMediaModel({
    this.original_msgid = '',
    this.list = const [],
    this.media_ids = '',
    this.type = 0,
    this.num = 0,
  });

  List<String> getTags() {
    var tagSet = <String>{};
    for (var item in list) {
      tagSet.addAll(item.tags);
    }
    return tagSet.map((tag) => '#$tag').toList();
  }

  factory PackageMediaModel.fromJson(Map<String, dynamic> json) {
    return PackageMediaModel(
      original_msgid: json['original_msgid'] as String? ?? '',
      list: (json['list'] as List<dynamic>)
          .map(
            (item) => PackageMediaItem.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      media_ids: json['media_ids'] as String? ?? '',
      type: json['type'] as int? ?? 0,
      num: json['num'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original_msgid': original_msgid,
      'list': list.map((item) => item.toJson()).toList(),
      'media_ids': media_ids,
      'type': type,
      'num': num,
    };
  }
}

class PackageMediaItem {
  String url;
  String? thumb_url;
  int type;
  List<String> tags;

  PackageMediaItem({
    this.url = '',
    this.thumb_url,
    this.type = 0,
    this.tags = const [],
  });

  factory PackageMediaItem.fromJson(Map<String, dynamic> json) {
    return PackageMediaItem(
      url: json['url'] as String? ?? '',
      thumb_url: json['thumb_url'] as String?,
      type: json['type'] as int? ?? 0,
      tags: json['tags'] != null
          ? (json['tags'] as List<dynamic>).map((tag) => tag as String).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'thumb_url': thumb_url, 'type': type, 'tags': tags};
  }
}
