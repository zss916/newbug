import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/online_user_entity.g.dart';

export 'package:newbug/generated/json/online_user_entity.g.dart';

@JsonSerializable()
class OnlineUserEntity {
  @JSONField(name: 'user_id')
  String? userId;

  OnlineUserEntity();

  factory OnlineUserEntity.fromJson(Map<String, dynamic> json) =>
      $OnlineUserEntityFromJson(json);

  Map<String, dynamic> toJson() => $OnlineUserEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
