import 'dart:convert';

import 'package:newbug/core/helper/custom_annotation.dart';
import 'package:newbug/core/network/model/google_play_billing_entity.dart';
import 'package:newbug/core/network/model/location_entity.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/user_entity.g.dart';

export 'package:newbug/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JSONField(name: 'user_id')
  String? userId;
  @JSONField(name: 'nick_name')
  String? nickName;
  String? headimg;
  int? age;
  int? brithday;
  int? sexuality;
  int? sex;
  int? location;
  int? online;
  String? sign;
  @JSONField(name: 'is_hide')
  int? isHide;
  List<String>? tags;
  int? refer;
  @JSONField(name: 'is_model')
  bool? isModel;
  @JSONField(name: 'im_token')
  String? imToken;
  @JSONField(name: 'is_new_user')
  int? isNewUser;
  @JSONField(name: 'media_list')
  List<UserMediaList>? mediaList;
  int? block;
  @JSONField(name: 'push_config')
  int? pushConfig;
  Right? right;
  List<String>? desires;
  @JSONField(name: 'gift_tip_read')
  int? giftTipRead;
  int? aly;
  int? scene;
  @JSONField(name: 'is_pay')
  int? isPay;
  int? diamond;
  @JSONField(name: 'google_play_billing')
  GooglePlayBillingEntity? googlePlayBilling;
  @JSONField(name: 'verify_status')
  int? verifyStatus;
  @JSONField(name: 'svc_open_hit')
  bool? svcOpenHit;
  @JSONField(name: 'is_anchor')
  bool? isAnchor;
  int? balance;
  dynamic region;
  int? mode;
  @JSONField(name: 'is_sham')
  int? isSham;
  List<MediaListItem>? media;
  @JSONField(name: 'calling_duration')
  int? callingDuration;
  @JSONField(name: 'accumulate_balance')
  int? accumulateBalance;

  /// 胡须信息
  @JSONField(name: 'beard_info')
  BeardInfoType? beardInfo;

  @CustomAnnotation(description: "local")
  LocationEntity? locationInfo;

  UserEntity();

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      $UserEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  /// isNewUser == 1时，需要完善信息
  bool get isNeedEdit => isNewUser == 1;

  ///处理默认-62135596800 时间戳
  DateTime? get brithValue => (brithday ?? 0) < 0
      ? null
      : DateTime.fromMillisecondsSinceEpoch((brithday ?? 0) * 1000);

  ///是否是vip
  bool get isVip => right?.vip == 1;
}

@JsonSerializable()
class UserMediaList {
  int? type;
  String? url;
  int? width;
  int? height;
  int? size;
  int? duration;

  UserMediaList();

  factory UserMediaList.fromJson(Map<String, dynamic> json) =>
      $UserMediaListFromJson(json);

  Map<String, dynamic> toJson() => $UserMediaListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BeardInfoType {
  String? country;
  List<BeardType>? beards;

  BeardInfoType();

  factory BeardInfoType.fromJson(Map<String, dynamic> json) =>
      $BeardInfoTypeFromJson(json);

  Map<String, dynamic> toJson() => $BeardInfoTypeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BeardType {
  int? beard;
  @JSONField(name: 'beard_name')
  String? beardName;

  BeardType();

  factory BeardType.fromJson(Map<String, dynamic> json) =>
      $BeardTypeFromJson(json);

  Map<String, dynamic> toJson() => $BeardTypeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
