import 'package:newbug/core/network/model/check_order_entity.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

CheckOrderEntity $CheckOrderEntityFromJson(Map<String, dynamic> json) {
  final CheckOrderEntity checkOrderEntity = CheckOrderEntity();
  final int? isFirstPay = jsonConvert.convert<int>(json['is_first_pay']);
  if (isFirstPay != null) {
    checkOrderEntity.isFirstPay = isFirstPay;
  }
  final int? ok = jsonConvert.convert<int>(json['ok']);
  if (ok != null) {
    checkOrderEntity.ok = ok;
  }
  final String? orderId = jsonConvert.convert<String>(json['order_id']);
  if (orderId != null) {
    checkOrderEntity.orderId = orderId;
  }
  final double? reportMoney = jsonConvert.convert<double>(json['report_money']);
  if (reportMoney != null) {
    checkOrderEntity.reportMoney = reportMoney;
  }
  final Right? right = jsonConvert.convert<Right>(json['right']);
  if (right != null) {
    checkOrderEntity.right = right;
  }
  return checkOrderEntity;
}

Map<String, dynamic> $CheckOrderEntityToJson(CheckOrderEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['is_first_pay'] = entity.isFirstPay;
  data['ok'] = entity.ok;
  data['order_id'] = entity.orderId;
  data['report_money'] = entity.reportMoney;
  data['right'] = entity.right?.toJson();
  return data;
}

extension CheckOrderEntityExtension on CheckOrderEntity {
  CheckOrderEntity copyWith({
    int? isFirstPay,
    int? ok,
    String? orderId,
    double? reportMoney,
    Right? right,
  }) {
    return CheckOrderEntity()
      ..isFirstPay = isFirstPay ?? this.isFirstPay
      ..ok = ok ?? this.ok
      ..orderId = orderId ?? this.orderId
      ..reportMoney = reportMoney ?? this.reportMoney
      ..right = right ?? this.right;
  }
}
