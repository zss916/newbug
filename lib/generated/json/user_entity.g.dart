import 'package:newbug/core/network/model/google_play_billing_entity.dart';
import 'package:newbug/core/network/model/location_entity.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
  final UserEntity userEntity = UserEntity();
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    userEntity.userId = userId;
  }
  final String? nickName = jsonConvert.convert<String>(json['nick_name']);
  if (nickName != null) {
    userEntity.nickName = nickName;
  }
  final String? headimg = jsonConvert.convert<String>(json['headimg']);
  if (headimg != null) {
    userEntity.headimg = headimg;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    userEntity.age = age;
  }
  final int? brithday = jsonConvert.convert<int>(json['brithday']);
  if (brithday != null) {
    userEntity.brithday = brithday;
  }
  final int? sexuality = jsonConvert.convert<int>(json['sexuality']);
  if (sexuality != null) {
    userEntity.sexuality = sexuality;
  }
  final int? sex = jsonConvert.convert<int>(json['sex']);
  if (sex != null) {
    userEntity.sex = sex;
  }
  final int? location = jsonConvert.convert<int>(json['location']);
  if (location != null) {
    userEntity.location = location;
  }
  final int? online = jsonConvert.convert<int>(json['online']);
  if (online != null) {
    userEntity.online = online;
  }
  final String? sign = jsonConvert.convert<String>(json['sign']);
  if (sign != null) {
    userEntity.sign = sign;
  }
  final int? isHide = jsonConvert.convert<int>(json['is_hide']);
  if (isHide != null) {
    userEntity.isHide = isHide;
  }
  final List<String>? tags = (json['tags'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (tags != null) {
    userEntity.tags = tags;
  }
  final int? refer = jsonConvert.convert<int>(json['refer']);
  if (refer != null) {
    userEntity.refer = refer;
  }
  final bool? isModel = jsonConvert.convert<bool>(json['is_model']);
  if (isModel != null) {
    userEntity.isModel = isModel;
  }
  final String? imToken = jsonConvert.convert<String>(json['im_token']);
  if (imToken != null) {
    userEntity.imToken = imToken;
  }
  final int? isNewUser = jsonConvert.convert<int>(json['is_new_user']);
  if (isNewUser != null) {
    userEntity.isNewUser = isNewUser;
  }
  final List<UserMediaList>? mediaList = (json['media_list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<UserMediaList>(e) as UserMediaList)
      .toList();
  if (mediaList != null) {
    userEntity.mediaList = mediaList;
  }
  final int? block = jsonConvert.convert<int>(json['block']);
  if (block != null) {
    userEntity.block = block;
  }
  final int? pushConfig = jsonConvert.convert<int>(json['push_config']);
  if (pushConfig != null) {
    userEntity.pushConfig = pushConfig;
  }
  final Right? right = jsonConvert.convert<Right>(json['right']);
  if (right != null) {
    userEntity.right = right;
  }
  final List<String>? desires = (json['desires'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (desires != null) {
    userEntity.desires = desires;
  }
  final int? giftTipRead = jsonConvert.convert<int>(json['gift_tip_read']);
  if (giftTipRead != null) {
    userEntity.giftTipRead = giftTipRead;
  }
  final int? aly = jsonConvert.convert<int>(json['aly']);
  if (aly != null) {
    userEntity.aly = aly;
  }
  final int? scene = jsonConvert.convert<int>(json['scene']);
  if (scene != null) {
    userEntity.scene = scene;
  }
  final int? isPay = jsonConvert.convert<int>(json['is_pay']);
  if (isPay != null) {
    userEntity.isPay = isPay;
  }
  final int? diamond = jsonConvert.convert<int>(json['diamond']);
  if (diamond != null) {
    userEntity.diamond = diamond;
  }
  final GooglePlayBillingEntity? googlePlayBilling = jsonConvert
      .convert<GooglePlayBillingEntity>(json['google_play_billing']);
  if (googlePlayBilling != null) {
    userEntity.googlePlayBilling = googlePlayBilling;
  }
  final int? verifyStatus = jsonConvert.convert<int>(json['verify_status']);
  if (verifyStatus != null) {
    userEntity.verifyStatus = verifyStatus;
  }
  final bool? svcOpenHit = jsonConvert.convert<bool>(json['svc_open_hit']);
  if (svcOpenHit != null) {
    userEntity.svcOpenHit = svcOpenHit;
  }
  final bool? isAnchor = jsonConvert.convert<bool>(json['is_anchor']);
  if (isAnchor != null) {
    userEntity.isAnchor = isAnchor;
  }
  final int? balance = jsonConvert.convert<int>(json['balance']);
  if (balance != null) {
    userEntity.balance = balance;
  }
  final dynamic region = json['region'];
  if (region != null) {
    userEntity.region = region;
  }
  final int? mode = jsonConvert.convert<int>(json['mode']);
  if (mode != null) {
    userEntity.mode = mode;
  }
  final int? isSham = jsonConvert.convert<int>(json['is_sham']);
  if (isSham != null) {
    userEntity.isSham = isSham;
  }
  final List<MediaListItem>? media = (json['media'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MediaListItem>(e) as MediaListItem)
      .toList();
  if (media != null) {
    userEntity.media = media;
  }
  final int? callingDuration = jsonConvert.convert<int>(
    json['calling_duration'],
  );
  if (callingDuration != null) {
    userEntity.callingDuration = callingDuration;
  }
  final int? accumulateBalance = jsonConvert.convert<int>(
    json['accumulate_balance'],
  );
  if (accumulateBalance != null) {
    userEntity.accumulateBalance = accumulateBalance;
  }
  final BeardInfoType? beardInfo = jsonConvert.convert<BeardInfoType>(
    json['beard_info'],
  );
  if (beardInfo != null) {
    userEntity.beardInfo = beardInfo;
  }
  final LocationEntity? locationInfo = jsonConvert.convert<LocationEntity>(
    json['locationInfo'],
  );
  if (locationInfo != null) {
    userEntity.locationInfo = locationInfo;
  }
  return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user_id'] = entity.userId;
  data['nick_name'] = entity.nickName;
  data['headimg'] = entity.headimg;
  data['age'] = entity.age;
  data['brithday'] = entity.brithday;
  data['sexuality'] = entity.sexuality;
  data['sex'] = entity.sex;
  data['location'] = entity.location;
  data['online'] = entity.online;
  data['sign'] = entity.sign;
  data['is_hide'] = entity.isHide;
  data['tags'] = entity.tags;
  data['refer'] = entity.refer;
  data['is_model'] = entity.isModel;
  data['im_token'] = entity.imToken;
  data['is_new_user'] = entity.isNewUser;
  data['media_list'] = entity.mediaList?.map((v) => v.toJson()).toList();
  data['block'] = entity.block;
  data['push_config'] = entity.pushConfig;
  data['right'] = entity.right?.toJson();
  data['desires'] = entity.desires;
  data['gift_tip_read'] = entity.giftTipRead;
  data['aly'] = entity.aly;
  data['scene'] = entity.scene;
  data['is_pay'] = entity.isPay;
  data['diamond'] = entity.diamond;
  data['google_play_billing'] = entity.googlePlayBilling?.toJson();
  data['verify_status'] = entity.verifyStatus;
  data['svc_open_hit'] = entity.svcOpenHit;
  data['is_anchor'] = entity.isAnchor;
  data['balance'] = entity.balance;
  data['region'] = entity.region;
  data['mode'] = entity.mode;
  data['is_sham'] = entity.isSham;
  data['media'] = entity.media?.map((v) => v.toJson()).toList();
  data['calling_duration'] = entity.callingDuration;
  data['accumulate_balance'] = entity.accumulateBalance;
  data['beard_info'] = entity.beardInfo?.toJson();
  data['locationInfo'] = entity.locationInfo?.toJson();
  return data;
}

extension UserEntityExtension on UserEntity {
  UserEntity copyWith({
    String? userId,
    String? nickName,
    String? headimg,
    int? age,
    int? brithday,
    int? sexuality,
    int? sex,
    int? location,
    int? online,
    String? sign,
    int? isHide,
    List<String>? tags,
    int? refer,
    bool? isModel,
    String? imToken,
    int? isNewUser,
    List<UserMediaList>? mediaList,
    int? block,
    int? pushConfig,
    Right? right,
    List<String>? desires,
    int? giftTipRead,
    int? aly,
    int? scene,
    int? isPay,
    int? diamond,
    GooglePlayBillingEntity? googlePlayBilling,
    int? verifyStatus,
    bool? svcOpenHit,
    bool? isAnchor,
    int? balance,
    dynamic region,
    int? mode,
    int? isSham,
    List<MediaListItem>? media,
    int? callingDuration,
    int? accumulateBalance,
    BeardInfoType? beardInfo,
    LocationEntity? locationInfo,
  }) {
    return UserEntity()
      ..userId = userId ?? this.userId
      ..nickName = nickName ?? this.nickName
      ..headimg = headimg ?? this.headimg
      ..age = age ?? this.age
      ..brithday = brithday ?? this.brithday
      ..sexuality = sexuality ?? this.sexuality
      ..sex = sex ?? this.sex
      ..location = location ?? this.location
      ..online = online ?? this.online
      ..sign = sign ?? this.sign
      ..isHide = isHide ?? this.isHide
      ..tags = tags ?? this.tags
      ..refer = refer ?? this.refer
      ..isModel = isModel ?? this.isModel
      ..imToken = imToken ?? this.imToken
      ..isNewUser = isNewUser ?? this.isNewUser
      ..mediaList = mediaList ?? this.mediaList
      ..block = block ?? this.block
      ..pushConfig = pushConfig ?? this.pushConfig
      ..right = right ?? this.right
      ..desires = desires ?? this.desires
      ..giftTipRead = giftTipRead ?? this.giftTipRead
      ..aly = aly ?? this.aly
      ..scene = scene ?? this.scene
      ..isPay = isPay ?? this.isPay
      ..diamond = diamond ?? this.diamond
      ..googlePlayBilling = googlePlayBilling ?? this.googlePlayBilling
      ..verifyStatus = verifyStatus ?? this.verifyStatus
      ..svcOpenHit = svcOpenHit ?? this.svcOpenHit
      ..isAnchor = isAnchor ?? this.isAnchor
      ..balance = balance ?? this.balance
      ..region = region ?? this.region
      ..mode = mode ?? this.mode
      ..isSham = isSham ?? this.isSham
      ..media = media ?? this.media
      ..callingDuration = callingDuration ?? this.callingDuration
      ..accumulateBalance = accumulateBalance ?? this.accumulateBalance
      ..beardInfo = beardInfo ?? this.beardInfo
      ..locationInfo = locationInfo ?? this.locationInfo;
  }
}

UserMediaList $UserMediaListFromJson(Map<String, dynamic> json) {
  final UserMediaList userMediaList = UserMediaList();
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    userMediaList.type = type;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    userMediaList.url = url;
  }
  final int? width = jsonConvert.convert<int>(json['width']);
  if (width != null) {
    userMediaList.width = width;
  }
  final int? height = jsonConvert.convert<int>(json['height']);
  if (height != null) {
    userMediaList.height = height;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    userMediaList.size = size;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    userMediaList.duration = duration;
  }
  return userMediaList;
}

Map<String, dynamic> $UserMediaListToJson(UserMediaList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['url'] = entity.url;
  data['width'] = entity.width;
  data['height'] = entity.height;
  data['size'] = entity.size;
  data['duration'] = entity.duration;
  return data;
}

extension UserMediaListExtension on UserMediaList {
  UserMediaList copyWith({
    int? type,
    String? url,
    int? width,
    int? height,
    int? size,
    int? duration,
  }) {
    return UserMediaList()
      ..type = type ?? this.type
      ..url = url ?? this.url
      ..width = width ?? this.width
      ..height = height ?? this.height
      ..size = size ?? this.size
      ..duration = duration ?? this.duration;
  }
}

BeardInfoType $BeardInfoTypeFromJson(Map<String, dynamic> json) {
  final BeardInfoType beardInfoType = BeardInfoType();
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    beardInfoType.country = country;
  }
  final List<BeardType>? beards = (json['beards'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<BeardType>(e) as BeardType)
      .toList();
  if (beards != null) {
    beardInfoType.beards = beards;
  }
  return beardInfoType;
}

Map<String, dynamic> $BeardInfoTypeToJson(BeardInfoType entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['country'] = entity.country;
  data['beards'] = entity.beards?.map((v) => v.toJson()).toList();
  return data;
}

extension BeardInfoTypeExtension on BeardInfoType {
  BeardInfoType copyWith({String? country, List<BeardType>? beards}) {
    return BeardInfoType()
      ..country = country ?? this.country
      ..beards = beards ?? this.beards;
  }
}

BeardType $BeardTypeFromJson(Map<String, dynamic> json) {
  final BeardType beardType = BeardType();
  final int? beard = jsonConvert.convert<int>(json['beard']);
  if (beard != null) {
    beardType.beard = beard;
  }
  final String? beardName = jsonConvert.convert<String>(json['beard_name']);
  if (beardName != null) {
    beardType.beardName = beardName;
  }
  return beardType;
}

Map<String, dynamic> $BeardTypeToJson(BeardType entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['beard'] = entity.beard;
  data['beard_name'] = entity.beardName;
  return data;
}

extension BeardTypeExtension on BeardType {
  BeardType copyWith({int? beard, String? beardName}) {
    return BeardType()
      ..beard = beard ?? this.beard
      ..beardName = beardName ?? this.beardName;
  }
}
