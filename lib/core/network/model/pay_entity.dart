import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/pay_entity.g.dart';

export 'package:newbug/generated/json/pay_entity.g.dart';

@JsonSerializable()
class PayEntity {
  @JSONField(name: 'default')
  int? defaultSelected;
  @JSONField(name: 'page_desc1')
  String? pageDesc1;
  @JSONField(name: 'page_desc2')
  String? pageDesc2;
  PayRight? right;
  List<PayRights>? rights;
  List<PayShops>? shops;

  PayEntity();

  factory PayEntity.fromJson(Map<String, dynamic> json) =>
      $PayEntityFromJson(json);

  Map<String, dynamic> toJson() => $PayEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PayRight {
  @JSONField(name: 'effect_chat_cnt')
  int? effectChatCnt;
  int? flashchat;
  @JSONField(name: 'im_lock_type')
  int? imLockType;
  @JSONField(name: 'like_cnt')
  int? likeCnt;
  int? privacyimage;
  int? privacyvideo;
  @JSONField(name: 'swipe_cnt')
  int? swipeCnt;
  int? vip;

  PayRight();

  factory PayRight.fromJson(Map<String, dynamic> json) =>
      $PayRightFromJson(json);

  Map<String, dynamic> toJson() => $PayRightToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PayRights {
  String? desc;
  @JSONField(name: 'desc_list')
  List<String>? descList;
  String? icon;
  @JSONField(name: 'icon_s')
  String? iconS;
  String? title;

  PayRights();

  factory PayRights.fromJson(Map<String, dynamic> json) =>
      $PayRightsFromJson(json);

  Map<String, dynamic> toJson() => $PayRightsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PayShops {
  String? average;
  String? currency;
  int? hot;
  String? name;
  String? price;
  @JSONField(name: 'price_fvalue')
  double? priceFvalue;
  @JSONField(name: 'price_value')
  int? priceValue;
  @JSONField(name: 'prod_id')
  String? prodId;
  @JSONField(name: 'product_type')
  String? productType;
  String? save;
  int? subscribing;
  String? time;
  String? uint;

  PayShops();

  factory PayShops.fromJson(Map<String, dynamic> json) =>
      $PayShopsFromJson(json);

  Map<String, dynamic> toJson() => $PayShopsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
