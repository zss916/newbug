import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

Right $RightFromJson(Map<String, dynamic> json) {
  final Right right = Right();
  final int? vip = jsonConvert.convert<int>(json['vip']);
  if (vip != null) {
    right.vip = vip;
  }
  final int? flashchat = jsonConvert.convert<int>(json['flashchat']);
  if (flashchat != null) {
    right.flashchat = flashchat;
  }
  final int? privacyvideo = jsonConvert.convert<int>(json['privacyvideo']);
  if (privacyvideo != null) {
    right.privacyvideo = privacyvideo;
  }
  final int? privacyimage = jsonConvert.convert<int>(json['privacyimage']);
  if (privacyimage != null) {
    right.privacyimage = privacyimage;
  }
  final int? likeCnt = jsonConvert.convert<int>(json['like_cnt']);
  if (likeCnt != null) {
    right.likeCnt = likeCnt;
  }
  final int? imLockType = jsonConvert.convert<int>(json['im_lock_type']);
  if (imLockType != null) {
    right.imLockType = imLockType;
  }
  final int? swipeCnt = jsonConvert.convert<int>(json['swipe_cnt']);
  if (swipeCnt != null) {
    right.swipeCnt = swipeCnt;
  }
  final int? effectChatCnt = jsonConvert.convert<int>(json['effect_chat_cnt']);
  if (effectChatCnt != null) {
    right.effectChatCnt = effectChatCnt;
  }
  return right;
}

Map<String, dynamic> $RightToJson(Right entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['vip'] = entity.vip;
  data['flashchat'] = entity.flashchat;
  data['privacyvideo'] = entity.privacyvideo;
  data['privacyimage'] = entity.privacyimage;
  data['like_cnt'] = entity.likeCnt;
  data['im_lock_type'] = entity.imLockType;
  data['swipe_cnt'] = entity.swipeCnt;
  data['effect_chat_cnt'] = entity.effectChatCnt;
  return data;
}

extension RightExtension on Right {
  Right copyWith({
    int? vip,
    int? flashchat,
    int? privacyvideo,
    int? privacyimage,
    int? likeCnt,
    int? imLockType,
    int? swipeCnt,
    int? effectChatCnt,
  }) {
    return Right()
      ..vip = vip ?? this.vip
      ..flashchat = flashchat ?? this.flashchat
      ..privacyvideo = privacyvideo ?? this.privacyvideo
      ..privacyimage = privacyimage ?? this.privacyimage
      ..likeCnt = likeCnt ?? this.likeCnt
      ..imLockType = imLockType ?? this.imLockType
      ..swipeCnt = swipeCnt ?? this.swipeCnt
      ..effectChatCnt = effectChatCnt ?? this.effectChatCnt;
  }
}
