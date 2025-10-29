import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/people_entity.g.dart';

export 'package:newbug/generated/json/people_entity.g.dart';

@JsonSerializable()
class PeopleEntity {
  int? age;
  int? id;
  int? location;
  @JSONField(name: 'media_list')
  List<PeopleMediaList>? mediaList;
  int? nearby;
  @JSONField(name: 'nick_name')
  String? nickName;
  int? online;

  ///0未读 1已读
  int? read;
  @JSONField(name: 'time_out')
  String? timeOut;
  @JSONField(name: 'user_id')
  int? userId;

  ///visitor
  int? viewCount;

  PeopleEntity();

  factory PeopleEntity.fromJson(Map<String, dynamic> json) =>
      $PeopleEntityFromJson(json);

  Map<String, dynamic> toJson() => $PeopleEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PeopleMediaList {
  int? duration;
  int? height;
  int? size;
  int? type;
  String? url;
  int? width;

  PeopleMediaList();

  factory PeopleMediaList.fromJson(Map<String, dynamic> json) =>
      $PeopleMediaListFromJson(json);

  Map<String, dynamic> toJson() => $PeopleMediaListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
