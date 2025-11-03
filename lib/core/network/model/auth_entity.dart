import 'dart:convert';

import 'package:newbug/generated/json/auth_entity.g.dart';
import 'package:newbug/generated/json/base/json_field.dart';

export 'package:newbug/generated/json/auth_entity.g.dart';

@JsonSerializable()
class AuthEntity {
  @JSONField(name: 'user_id')
  int? userId;
  @JSONField(name: 'auth_token')
  String? authToken;
  @JSONField(name: 'im_token')
  String? imToken;
  @JSONField(name: 'expire_at')
  int? expireAt;
  @JSONField(name: 'nick_name')
  String? nickName;
  String? headimg;
  @JSONField(name: 'is_new_user')
  int? isNewUser;
  String? sign;
  int? sex;
  int? age;
  @JSONField(name: 'is_hide')
  int? isHide;
  int? brithday;
  @JSONField(name: 'media_list')
  List<AuthMediaList>? mediaList;
  dynamic tags;
  @JSONField(name: 'push_config')
  int? pushConfig;
  AuthRight? right;
  @JSONField(name: 'is_today_sign')
  bool? isTodaySign;
  int? role;
  int? aly;
  String? waUrl;
  int? scene;
  @JSONField(name: 'is_pay')
  int? isPay;
  @JSONField(name: 'is_anchor')
  bool? isAnchor;
  int? mode;

  AuthEntity();

  factory AuthEntity.fromJson(Map<String, dynamic> json) =>
      $AuthEntityFromJson(json);

  Map<String, dynamic> toJson() => $AuthEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  /// isNewUser == 1时，需要完善信息
  bool get isNeedEdit => isNewUser == 1;
}

@JsonSerializable()
class AuthMediaList {
  int? type;
  String? url;
  int? width;
  int? height;
  int? size;
  int? duration;

  AuthMediaList();

  factory AuthMediaList.fromJson(Map<String, dynamic> json) =>
      $AuthMediaListFromJson(json);

  Map<String, dynamic> toJson() => $AuthMediaListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AuthRight {
  int? vip;
  int? flashchat;
  int? privacyvideo;
  int? privacyimage;
  @JSONField(name: 'like_cnt')
  int? likeCnt;
  @JSONField(name: 'im_lock_type')
  int? imLockType;
  @JSONField(name: 'swipe_cnt')
  int? swipeCnt;
  @JSONField(name: 'effect_chat_cnt')
  int? effectChatCnt;
  @JSONField(name: 'vc_duration')
  int? vcDuration;

  AuthRight();

  factory AuthRight.fromJson(Map<String, dynamic> json) =>
      $AuthRightFromJson(json);

  Map<String, dynamic> toJson() => $AuthRightToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
