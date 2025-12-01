import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:newbug/core/network/model/check_order_entity.dart';
import 'package:newbug/core/network/model/order_entity.dart';
import 'package:newbug/core/network/model/pay_entity.dart';
import 'package:newbug/core/network/net/net.dart';
import 'package:newbug/core/network/path/netPath.dart';
import 'package:newbug/core/widget/index.dart';

abstract class PayAPI {
  /// 获取商品列表
  static Future<PayEntity?> getProductList({required int type}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.productList,
        queryParameters: {"type": type},
      );
      if (result["code"] == 0) {
        PayEntity value = await compute(
          (dynamic jsonStr) => PayEntity.fromJson(jsonStr),
          result["data"],
        );
        return value;
      } else {
        CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  /// 创建订单
  static Future<OrderEntity?> createOrder({required String productId}) async {
    try {
      final result = await Net.instance.post(
        ApiPath.createOrder,
        queryParameters: {
          "prod_id": productId,
          "pay_plat": Platform.isAndroid ? 1 : 2,
        },
      );
      if (result["code"] == 0) {
        OrderEntity value = await compute(
          (dynamic jsonStr) => OrderEntity.fromJson(jsonStr),
          result["data"],
        );
        return value;
      } else {
        CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  /// 验证订单
  static Future<CheckOrderEntity?> checkOrder({
    required String orderId,
    required String thirdId,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.checkOrder,
        queryParameters: {"order_id": orderId, "third_id": thirdId},
      );
      if (result["code"] == 0) {
        CheckOrderEntity value = await compute(
          (dynamic jsonStr) => CheckOrderEntity.fromJson(jsonStr),
          result["data"],
        );
        return value;
      } else {
        CustomToast.fail("Failed");
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  /// 支付打点
  static Future<bool> payTrace(
    int paySceneFrom,
    int paySceneSourceType,
    int paySceneValue, {
    Map<String, dynamic>? extra,
  }) async {
    try {
      final result = await Net.instance.post(
        ApiPath.payTrace,
        queryParameters: {
          "event_from": paySceneFrom,
          "event_id": paySceneSourceType,
          "event_param": paySceneValue,
          "extra": extra,
        },
      );
      return result["code"] == 0;
    } catch (error) {
      return false;
    }
  }
}
