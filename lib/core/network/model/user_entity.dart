import 'dart:convert';

import 'package:newbug/core/helper/date_helper.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  //int? aly;
  //@JSONField(name: 'is_pay')
  //int? isPay;
  //@JSONField(name: 'is_anchor')
  //bool? isAnchor;
  //int? mode;

  int? id;
  @JSONField(name: 'user_id')
  String? userId;
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
  int? sexuality;

  ///1: "Male", 2: "Female",
  int? sex;
  int? age;
  @JSONField(name: 'is_hide')
  int? isHide;

  ///拉黑 1拉黑 0未拉黑
  int? block;
  int? online;
  int? brithday;
  int? location;
  @JSONField(name: 'media_list')
  List<MediaListItem>? mediaList;

  List<String>? tags;
  List<String>? desires;
  @JSONField(name: 'push_config')
  int? pushConfig;
  Right? right;
  @JSONField(name: 'is_today_sign')
  bool? isTodaySign;

  ///建联关系 0已经建联，1自己like了对方，2对方like了自己，3没任何关系
  int? refer;

  /// 1非普通
  int? role;

  ///密友
  int? confidant;

  ///fc msg
  String? msg;

  ///party
  List<PartyItem>? parties;
  PartyItem? party;
  int? partyId;
  String? address;
  String? waUrl;

  /// 页面模式 1 A面 2 B面 3 FB面
  int? scene;

  /// 胡须信息
  @JSONField(name: 'beard_info')
  BeardInfoType? beardInfo;

  bool? follow;
  @JSONField(name: 'follow_me')
  bool? followMe;
  bool? isFriend;
  @JSONField(name: 'moment_list')
  List<MomentListModel>? momentList;

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
}

@JsonSerializable()
class PartyItem {
  int? id;
  String? name;
  String? city;
  String? location;
  String? coverImg;
  int? partyTime;
  int? member;
  int? memberNum;
  List<Members>? members;

  PartyItem();

  factory PartyItem.fromJson(Map<String, dynamic> json) =>
      $PartyItemFromJson(json);

  Map<String, dynamic> toJson() => $PartyItemToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  /// 获取location  信息
  String getLocationInfo() {
    /// city 与location都不为空时，返回location,location
    if (city != null && location != null) {
      return '$location,$city';
    }

    /// city为空时，返回location
    if (city == null) {
      return location ?? '';
    }
    return city ?? '';
  }

  ///获取首页城市时间信息
  String getCityTimeInfo() {
    /// city 与partyTime都不为空时，返回city,partyTime
    if (city != null && partyTime != null) {
      return "${city ?? ""} | ${(partyTime ?? 0).timestampFormatted}";
    }

    /// city为空时，返回partyTime
    if (city == null) {
      return (partyTime ?? 0).timestampFormatted;
    }

    return city ?? '';
  }
}

@JsonSerializable()
class Members {
  String? headimg;

  /// nick_name
  String? nickName;

  /// user_id
  int? userId;

  Members();

  factory Members.fromJson(Map<String, dynamic> json) => $MembersFromJson(json);

  Map<String, dynamic> toJson() => $MembersToJson(this);

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

@JsonSerializable()
class MomentListModel {
  int? id;
  int? userId;
  String? nickName;
  String? headimg;
  int? follow;
  int? isFriend;
  String? country;
  String? content;
  List<MediaListItem>? media;

  MomentListModel();

  factory MomentListModel.fromJson(Map<String, dynamic> json) =>
      $MomentListModelFromJson(json);

  Map<String, dynamic> toJson() => $MomentListModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
