import 'dart:convert';

import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/people_entity.g.dart';

export 'package:newbug/generated/json/people_entity.g.dart';

@JsonSerializable()
class PeopleEntity {
  int? age;
  int? id;
  int? location;
  @JSONField(name: 'media_list')
  List<MediaListItem>? mediaList;
  int? nearby;
  @JSONField(name: 'nick_name')
  String? nickName;
  int? online;

  ///1 在线

  ///0未读 1已读
  int? read;
  @JSONField(name: 'time_out')
  String? timeOut;
  @JSONField(name: 'user_id')
  int? userId;

  ///visitor
  int? viewCount;

  String? headimg;

  PeopleEntity();

  factory PeopleEntity.fromJson(Map<String, dynamic> json) =>
      $PeopleEntityFromJson(json);

  Map<String, dynamic> toJson() => $PeopleEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  ///是否在线
  bool get isOnline => online == 1;

  ///是否上新
  bool get isNew => read == 0;
}
