import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/order_entity.g.dart';

export 'package:newbug/generated/json/order_entity.g.dart';

@JsonSerializable()
class OrderEntity {
  @JSONField(name: 'order_id')
  String? orderId;
  @JSONField(name: 'prod_id')
  String? prodId;
  @JSONField(name: 'product_type')
  String? productType;
  @JSONField(name: 'pay_channel')
  int? payChannel;
  @JSONField(name: 'has_action')
  bool? hasAction;
  @JSONField(name: 'err_action')
  Map<String, dynamic>? errAction;

  OrderEntity();

  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      $OrderEntityFromJson(json);

  Map<String, dynamic> toJson() => $OrderEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
