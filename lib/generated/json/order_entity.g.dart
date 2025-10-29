import 'package:newbug/core/network/model/order_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

OrderEntity $OrderEntityFromJson(Map<String, dynamic> json) {
  final OrderEntity orderEntity = OrderEntity();
  final String? orderId = jsonConvert.convert<String>(json['order_id']);
  if (orderId != null) {
    orderEntity.orderId = orderId;
  }
  final String? prodId = jsonConvert.convert<String>(json['prod_id']);
  if (prodId != null) {
    orderEntity.prodId = prodId;
  }
  final String? productType = jsonConvert.convert<String>(json['product_type']);
  if (productType != null) {
    orderEntity.productType = productType;
  }
  final int? payChannel = jsonConvert.convert<int>(json['pay_channel']);
  if (payChannel != null) {
    orderEntity.payChannel = payChannel;
  }
  final bool? hasAction = jsonConvert.convert<bool>(json['has_action']);
  if (hasAction != null) {
    orderEntity.hasAction = hasAction;
  }
  final Map<String, dynamic>? errAction =
      (json['err_action'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e),
      );
  if (errAction != null) {
    orderEntity.errAction = errAction;
  }
  return orderEntity;
}

Map<String, dynamic> $OrderEntityToJson(OrderEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['order_id'] = entity.orderId;
  data['prod_id'] = entity.prodId;
  data['product_type'] = entity.productType;
  data['pay_channel'] = entity.payChannel;
  data['has_action'] = entity.hasAction;
  data['err_action'] = entity.errAction;
  return data;
}

extension OrderEntityExtension on OrderEntity {
  OrderEntity copyWith({
    String? orderId,
    String? prodId,
    String? productType,
    int? payChannel,
    bool? hasAction,
    Map<String, dynamic>? errAction,
  }) {
    return OrderEntity()
      ..orderId = orderId ?? this.orderId
      ..prodId = prodId ?? this.prodId
      ..productType = productType ?? this.productType
      ..payChannel = payChannel ?? this.payChannel
      ..hasAction = hasAction ?? this.hasAction
      ..errAction = errAction ?? this.errAction;
  }
}
