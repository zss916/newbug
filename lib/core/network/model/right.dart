import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/right.g.dart';

@JsonSerializable()
class Right {
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
  //@JSONField(name: 'vc_duration')
  //int? vcDuration;

  Right();

  factory Right.fromJson(Map<String, dynamic> json) => $RightFromJson(json);

  Map<String, dynamic> toJson() => $RightToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
