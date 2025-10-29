import 'dart:convert';

import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/check_order_entity.g.dart';

export 'package:newbug/generated/json/check_order_entity.g.dart';

@JsonSerializable()
class CheckOrderEntity {
  @JSONField(name: 'is_first_pay')
  int? isFirstPay;
  int? ok;
  @JSONField(name: 'order_id')
  String? orderId;
  @JSONField(name: 'report_money')
  double? reportMoney;
  Right? right;

  CheckOrderEntity();

  factory CheckOrderEntity.fromJson(Map<String, dynamic> json) =>
      $CheckOrderEntityFromJson(json);

  Map<String, dynamic> toJson() => $CheckOrderEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
