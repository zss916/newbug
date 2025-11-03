import 'package:newbug/core/network/model/auth_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

AuthEntity $AuthEntityFromJson(Map<String, dynamic> json) {
  final AuthEntity authEntity = AuthEntity();
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    authEntity.userId = userId;
  }
  final String? authToken = jsonConvert.convert<String>(json['auth_token']);
  if (authToken != null) {
    authEntity.authToken = authToken;
  }
  final String? imToken = jsonConvert.convert<String>(json['im_token']);
  if (imToken != null) {
    authEntity.imToken = imToken;
  }
  final int? expireAt = jsonConvert.convert<int>(json['expire_at']);
  if (expireAt != null) {
    authEntity.expireAt = expireAt;
  }
  final String? nickName = jsonConvert.convert<String>(json['nick_name']);
  if (nickName != null) {
    authEntity.nickName = nickName;
  }
  final String? headimg = jsonConvert.convert<String>(json['headimg']);
  if (headimg != null) {
    authEntity.headimg = headimg;
  }
  final int? isNewUser = jsonConvert.convert<int>(json['is_new_user']);
  if (isNewUser != null) {
    authEntity.isNewUser = isNewUser;
  }
  final String? sign = jsonConvert.convert<String>(json['sign']);
  if (sign != null) {
    authEntity.sign = sign;
  }
  final int? sex = jsonConvert.convert<int>(json['sex']);
  if (sex != null) {
    authEntity.sex = sex;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    authEntity.age = age;
  }
  final int? isHide = jsonConvert.convert<int>(json['is_hide']);
  if (isHide != null) {
    authEntity.isHide = isHide;
  }
  final int? brithday = jsonConvert.convert<int>(json['brithday']);
  if (brithday != null) {
    authEntity.brithday = brithday;
  }
  final List<AuthMediaList>? mediaList = (json['media_list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<AuthMediaList>(e) as AuthMediaList)
      .toList();
  if (mediaList != null) {
    authEntity.mediaList = mediaList;
  }
  final dynamic tags = json['tags'];
  if (tags != null) {
    authEntity.tags = tags;
  }
  final int? pushConfig = jsonConvert.convert<int>(json['push_config']);
  if (pushConfig != null) {
    authEntity.pushConfig = pushConfig;
  }
  final AuthRight? right = jsonConvert.convert<AuthRight>(json['right']);
  if (right != null) {
    authEntity.right = right;
  }
  final bool? isTodaySign = jsonConvert.convert<bool>(json['is_today_sign']);
  if (isTodaySign != null) {
    authEntity.isTodaySign = isTodaySign;
  }
  final int? role = jsonConvert.convert<int>(json['role']);
  if (role != null) {
    authEntity.role = role;
  }
  final int? aly = jsonConvert.convert<int>(json['aly']);
  if (aly != null) {
    authEntity.aly = aly;
  }
  final String? waUrl = jsonConvert.convert<String>(json['waUrl']);
  if (waUrl != null) {
    authEntity.waUrl = waUrl;
  }
  final int? scene = jsonConvert.convert<int>(json['scene']);
  if (scene != null) {
    authEntity.scene = scene;
  }
  final int? isPay = jsonConvert.convert<int>(json['is_pay']);
  if (isPay != null) {
    authEntity.isPay = isPay;
  }
  final bool? isAnchor = jsonConvert.convert<bool>(json['is_anchor']);
  if (isAnchor != null) {
    authEntity.isAnchor = isAnchor;
  }
  final int? mode = jsonConvert.convert<int>(json['mode']);
  if (mode != null) {
    authEntity.mode = mode;
  }
  return authEntity;
}

Map<String, dynamic> $AuthEntityToJson(AuthEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user_id'] = entity.userId;
  data['auth_token'] = entity.authToken;
  data['im_token'] = entity.imToken;
  data['expire_at'] = entity.expireAt;
  data['nick_name'] = entity.nickName;
  data['headimg'] = entity.headimg;
  data['is_new_user'] = entity.isNewUser;
  data['sign'] = entity.sign;
  data['sex'] = entity.sex;
  data['age'] = entity.age;
  data['is_hide'] = entity.isHide;
  data['brithday'] = entity.brithday;
  data['media_list'] = entity.mediaList?.map((v) => v.toJson()).toList();
  data['tags'] = entity.tags;
  data['push_config'] = entity.pushConfig;
  data['right'] = entity.right?.toJson();
  data['is_today_sign'] = entity.isTodaySign;
  data['role'] = entity.role;
  data['aly'] = entity.aly;
  data['waUrl'] = entity.waUrl;
  data['scene'] = entity.scene;
  data['is_pay'] = entity.isPay;
  data['is_anchor'] = entity.isAnchor;
  data['mode'] = entity.mode;
  return data;
}

extension AuthEntityExtension on AuthEntity {
  AuthEntity copyWith({
    int? userId,
    String? authToken,
    String? imToken,
    int? expireAt,
    String? nickName,
    String? headimg,
    int? isNewUser,
    String? sign,
    int? sex,
    int? age,
    int? isHide,
    int? brithday,
    List<AuthMediaList>? mediaList,
    dynamic tags,
    int? pushConfig,
    AuthRight? right,
    bool? isTodaySign,
    int? role,
    int? aly,
    String? waUrl,
    int? scene,
    int? isPay,
    bool? isAnchor,
    int? mode,
  }) {
    return AuthEntity()
      ..userId = userId ?? this.userId
      ..authToken = authToken ?? this.authToken
      ..imToken = imToken ?? this.imToken
      ..expireAt = expireAt ?? this.expireAt
      ..nickName = nickName ?? this.nickName
      ..headimg = headimg ?? this.headimg
      ..isNewUser = isNewUser ?? this.isNewUser
      ..sign = sign ?? this.sign
      ..sex = sex ?? this.sex
      ..age = age ?? this.age
      ..isHide = isHide ?? this.isHide
      ..brithday = brithday ?? this.brithday
      ..mediaList = mediaList ?? this.mediaList
      ..tags = tags ?? this.tags
      ..pushConfig = pushConfig ?? this.pushConfig
      ..right = right ?? this.right
      ..isTodaySign = isTodaySign ?? this.isTodaySign
      ..role = role ?? this.role
      ..aly = aly ?? this.aly
      ..waUrl = waUrl ?? this.waUrl
      ..scene = scene ?? this.scene
      ..isPay = isPay ?? this.isPay
      ..isAnchor = isAnchor ?? this.isAnchor
      ..mode = mode ?? this.mode;
  }
}

AuthMediaList $AuthMediaListFromJson(Map<String, dynamic> json) {
  final AuthMediaList authMediaList = AuthMediaList();
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    authMediaList.type = type;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    authMediaList.url = url;
  }
  final int? width = jsonConvert.convert<int>(json['width']);
  if (width != null) {
    authMediaList.width = width;
  }
  final int? height = jsonConvert.convert<int>(json['height']);
  if (height != null) {
    authMediaList.height = height;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    authMediaList.size = size;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    authMediaList.duration = duration;
  }
  return authMediaList;
}

Map<String, dynamic> $AuthMediaListToJson(AuthMediaList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['url'] = entity.url;
  data['width'] = entity.width;
  data['height'] = entity.height;
  data['size'] = entity.size;
  data['duration'] = entity.duration;
  return data;
}

extension AuthMediaListExtension on AuthMediaList {
  AuthMediaList copyWith({
    int? type,
    String? url,
    int? width,
    int? height,
    int? size,
    int? duration,
  }) {
    return AuthMediaList()
      ..type = type ?? this.type
      ..url = url ?? this.url
      ..width = width ?? this.width
      ..height = height ?? this.height
      ..size = size ?? this.size
      ..duration = duration ?? this.duration;
  }
}

AuthRight $AuthRightFromJson(Map<String, dynamic> json) {
  final AuthRight authRight = AuthRight();
  final int? vip = jsonConvert.convert<int>(json['vip']);
  if (vip != null) {
    authRight.vip = vip;
  }
  final int? flashchat = jsonConvert.convert<int>(json['flashchat']);
  if (flashchat != null) {
    authRight.flashchat = flashchat;
  }
  final int? privacyvideo = jsonConvert.convert<int>(json['privacyvideo']);
  if (privacyvideo != null) {
    authRight.privacyvideo = privacyvideo;
  }
  final int? privacyimage = jsonConvert.convert<int>(json['privacyimage']);
  if (privacyimage != null) {
    authRight.privacyimage = privacyimage;
  }
  final int? likeCnt = jsonConvert.convert<int>(json['like_cnt']);
  if (likeCnt != null) {
    authRight.likeCnt = likeCnt;
  }
  final int? imLockType = jsonConvert.convert<int>(json['im_lock_type']);
  if (imLockType != null) {
    authRight.imLockType = imLockType;
  }
  final int? swipeCnt = jsonConvert.convert<int>(json['swipe_cnt']);
  if (swipeCnt != null) {
    authRight.swipeCnt = swipeCnt;
  }
  final int? effectChatCnt = jsonConvert.convert<int>(json['effect_chat_cnt']);
  if (effectChatCnt != null) {
    authRight.effectChatCnt = effectChatCnt;
  }
  final int? vcDuration = jsonConvert.convert<int>(json['vc_duration']);
  if (vcDuration != null) {
    authRight.vcDuration = vcDuration;
  }
  return authRight;
}

Map<String, dynamic> $AuthRightToJson(AuthRight entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['vip'] = entity.vip;
  data['flashchat'] = entity.flashchat;
  data['privacyvideo'] = entity.privacyvideo;
  data['privacyimage'] = entity.privacyimage;
  data['like_cnt'] = entity.likeCnt;
  data['im_lock_type'] = entity.imLockType;
  data['swipe_cnt'] = entity.swipeCnt;
  data['effect_chat_cnt'] = entity.effectChatCnt;
  data['vc_duration'] = entity.vcDuration;
  return data;
}

extension AuthRightExtension on AuthRight {
  AuthRight copyWith({
    int? vip,
    int? flashchat,
    int? privacyvideo,
    int? privacyimage,
    int? likeCnt,
    int? imLockType,
    int? swipeCnt,
    int? effectChatCnt,
    int? vcDuration,
  }) {
    return AuthRight()
      ..vip = vip ?? this.vip
      ..flashchat = flashchat ?? this.flashchat
      ..privacyvideo = privacyvideo ?? this.privacyvideo
      ..privacyimage = privacyimage ?? this.privacyimage
      ..likeCnt = likeCnt ?? this.likeCnt
      ..imLockType = imLockType ?? this.imLockType
      ..swipeCnt = swipeCnt ?? this.swipeCnt
      ..effectChatCnt = effectChatCnt ?? this.effectChatCnt
      ..vcDuration = vcDuration ?? this.vcDuration;
  }
}
