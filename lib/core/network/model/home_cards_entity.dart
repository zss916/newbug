import 'dart:convert';

import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/home_cards_entity.g.dart';

export 'package:newbug/generated/json/home_cards_entity.g.dart';

@JsonSerializable()
class HomeCardsEntity {
  @JSONField(name: 'match_list')
  List<HomeCardsMatchList>? matchList;
  @JSONField(name: 'privacy_list')
  List<String>? privacyList;
  Right? rights;

  HomeCardsEntity();

  factory HomeCardsEntity.fromJson(Map<String, dynamic> json) =>
      $HomeCardsEntityFromJson(json);

  Map<String, dynamic> toJson() => $HomeCardsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeCardsMatchList {
  int? id;
  String? address;
  int? age;
  String? headimg;
  int? location;
  @JSONField(name: 'media_list')
  List<MediaListItem>? mediaList;
  @JSONField(name: 'nick_name')
  String? nickName;
  int? online;
  int? reviewing;
  @JSONField(name: 's_info')
  String? sInfo;
  String? sign;
  String? sticker;
  List<String>? tags;

  ///0-默认推荐卡片， 1-建联后未有效且7天不活跃， 2-建联成功后5天未破冰
  int? type;
  @JSONField(name: 'user_id')
  int? userId;

  ///新增
  bool? follow;
  bool? isFriend;

  /// PartyItem
  //PartyItem? party;

  /// 胡须信息
  BeardInfoType? beard_info;

  /// 是否已经发送了fc
  bool? hasSendFc;

  /// pass的点击加载结果
  bool passLoading = false;

  /// like的点击加载结果
  bool likeLoading = false;

  /// 是否已经swipe掉了
  bool isSwiped = false;

  HomeCardsMatchList();

  factory HomeCardsMatchList.fromJson(Map<String, dynamic> json) =>
      $HomeCardsMatchListFromJson(json);

  Map<String, dynamic> toJson() => $HomeCardsMatchListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
