import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/tag_entity.g.dart';

export 'package:newbug/generated/json/tag_entity.g.dart';

@JsonSerializable()
class TagEntity {
  String? desc;
  int? id;
  String? title;
  int? type;

  TagEntity();

  factory TagEntity.fromJson(Map<String, dynamic> json) =>
      $TagEntityFromJson(json);

  Map<String, dynamic> toJson() => $TagEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
