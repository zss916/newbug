import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/google_play_billing_entity.g.dart';

export 'package:newbug/generated/json/google_play_billing_entity.g.dart';

@JsonSerializable()
class GooglePlayBillingEntity {
  String? upgrade;
  String? downgrade;

  GooglePlayBillingEntity();

  factory GooglePlayBillingEntity.fromJson(Map<String, dynamic> json) =>
      $GooglePlayBillingEntityFromJson(json);

  Map<String, dynamic> toJson() => $GooglePlayBillingEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
