import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/location_entity.g.dart';

export 'package:newbug/generated/json/location_entity.g.dart';

@JsonSerializable()
class LocationEntity {
  @JSONField(name: 'states_id')
  int? statesId;
  String? address;

  LocationEntity();

  factory LocationEntity.fromJson(Map<String, dynamic> json) =>
      $LocationEntityFromJson(json);

  Map<String, dynamic> toJson() => $LocationEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
