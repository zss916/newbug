import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/black_item_entity.g.dart';

export 'package:newbug/generated/json/black_item_entity.g.dart';

@JsonSerializable()
class BlackItemEntity {
  int? userId;
  String? nickName;
  String? headimg;
  int? online;
  int? isNearBy;
  int? id;

  BlackItemEntity();

  factory BlackItemEntity.fromJson(Map<String, dynamic> json) =>
      $BlackItemEntityFromJson(json);

  Map<String, dynamic> toJson() => $BlackItemEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
