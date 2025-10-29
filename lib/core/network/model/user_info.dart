import 'dart:convert';

import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/user_info.g.dart';

@JsonSerializable()
class UserInfo {
  UserEntity? user;
  @JSONField(serialize: false, deserialize: false)
  Object? tagList;

  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      $UserInfoFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
