import 'package:newbug/core/network/model/pay_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

PayEntity $PayEntityFromJson(Map<String, dynamic> json) {
  final PayEntity payEntity = PayEntity();
  final int? defaultSelected = jsonConvert.convert<int>(json['default']);
  if (defaultSelected != null) {
    payEntity.defaultSelected = defaultSelected;
  }
  final String? pageDesc1 = jsonConvert.convert<String>(json['page_desc1']);
  if (pageDesc1 != null) {
    payEntity.pageDesc1 = pageDesc1;
  }
  final String? pageDesc2 = jsonConvert.convert<String>(json['page_desc2']);
  if (pageDesc2 != null) {
    payEntity.pageDesc2 = pageDesc2;
  }
  final PayRight? right = jsonConvert.convert<PayRight>(json['right']);
  if (right != null) {
    payEntity.right = right;
  }
  final List<PayRights>? rights = (json['rights'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<PayRights>(e) as PayRights)
      .toList();
  if (rights != null) {
    payEntity.rights = rights;
  }
  final List<PayShops>? shops = (json['shops'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<PayShops>(e) as PayShops)
      .toList();
  if (shops != null) {
    payEntity.shops = shops;
  }
  return payEntity;
}

Map<String, dynamic> $PayEntityToJson(PayEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['default'] = entity.defaultSelected;
  data['page_desc1'] = entity.pageDesc1;
  data['page_desc2'] = entity.pageDesc2;
  data['right'] = entity.right?.toJson();
  data['rights'] = entity.rights?.map((v) => v.toJson()).toList();
  data['shops'] = entity.shops?.map((v) => v.toJson()).toList();
  return data;
}

extension PayEntityExtension on PayEntity {
  PayEntity copyWith({
    int? defaultSelected,
    String? pageDesc1,
    String? pageDesc2,
    PayRight? right,
    List<PayRights>? rights,
    List<PayShops>? shops,
  }) {
    return PayEntity()
      ..defaultSelected = defaultSelected ?? this.defaultSelected
      ..pageDesc1 = pageDesc1 ?? this.pageDesc1
      ..pageDesc2 = pageDesc2 ?? this.pageDesc2
      ..right = right ?? this.right
      ..rights = rights ?? this.rights
      ..shops = shops ?? this.shops;
  }
}

PayRight $PayRightFromJson(Map<String, dynamic> json) {
  final PayRight payRight = PayRight();
  final int? effectChatCnt = jsonConvert.convert<int>(json['effect_chat_cnt']);
  if (effectChatCnt != null) {
    payRight.effectChatCnt = effectChatCnt;
  }
  final int? flashchat = jsonConvert.convert<int>(json['flashchat']);
  if (flashchat != null) {
    payRight.flashchat = flashchat;
  }
  final int? imLockType = jsonConvert.convert<int>(json['im_lock_type']);
  if (imLockType != null) {
    payRight.imLockType = imLockType;
  }
  final int? likeCnt = jsonConvert.convert<int>(json['like_cnt']);
  if (likeCnt != null) {
    payRight.likeCnt = likeCnt;
  }
  final int? privacyimage = jsonConvert.convert<int>(json['privacyimage']);
  if (privacyimage != null) {
    payRight.privacyimage = privacyimage;
  }
  final int? privacyvideo = jsonConvert.convert<int>(json['privacyvideo']);
  if (privacyvideo != null) {
    payRight.privacyvideo = privacyvideo;
  }
  final int? swipeCnt = jsonConvert.convert<int>(json['swipe_cnt']);
  if (swipeCnt != null) {
    payRight.swipeCnt = swipeCnt;
  }
  final int? vip = jsonConvert.convert<int>(json['vip']);
  if (vip != null) {
    payRight.vip = vip;
  }
  return payRight;
}

Map<String, dynamic> $PayRightToJson(PayRight entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['effect_chat_cnt'] = entity.effectChatCnt;
  data['flashchat'] = entity.flashchat;
  data['im_lock_type'] = entity.imLockType;
  data['like_cnt'] = entity.likeCnt;
  data['privacyimage'] = entity.privacyimage;
  data['privacyvideo'] = entity.privacyvideo;
  data['swipe_cnt'] = entity.swipeCnt;
  data['vip'] = entity.vip;
  return data;
}

extension PayRightExtension on PayRight {
  PayRight copyWith({
    int? effectChatCnt,
    int? flashchat,
    int? imLockType,
    int? likeCnt,
    int? privacyimage,
    int? privacyvideo,
    int? swipeCnt,
    int? vip,
  }) {
    return PayRight()
      ..effectChatCnt = effectChatCnt ?? this.effectChatCnt
      ..flashchat = flashchat ?? this.flashchat
      ..imLockType = imLockType ?? this.imLockType
      ..likeCnt = likeCnt ?? this.likeCnt
      ..privacyimage = privacyimage ?? this.privacyimage
      ..privacyvideo = privacyvideo ?? this.privacyvideo
      ..swipeCnt = swipeCnt ?? this.swipeCnt
      ..vip = vip ?? this.vip;
  }
}

PayRights $PayRightsFromJson(Map<String, dynamic> json) {
  final PayRights payRights = PayRights();
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    payRights.desc = desc;
  }
  final List<String>? descList = (json['desc_list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (descList != null) {
    payRights.descList = descList;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    payRights.icon = icon;
  }
  final String? iconS = jsonConvert.convert<String>(json['icon_s']);
  if (iconS != null) {
    payRights.iconS = iconS;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    payRights.title = title;
  }
  return payRights;
}

Map<String, dynamic> $PayRightsToJson(PayRights entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['desc'] = entity.desc;
  data['desc_list'] = entity.descList;
  data['icon'] = entity.icon;
  data['icon_s'] = entity.iconS;
  data['title'] = entity.title;
  return data;
}

extension PayRightsExtension on PayRights {
  PayRights copyWith({
    String? desc,
    List<String>? descList,
    String? icon,
    String? iconS,
    String? title,
  }) {
    return PayRights()
      ..desc = desc ?? this.desc
      ..descList = descList ?? this.descList
      ..icon = icon ?? this.icon
      ..iconS = iconS ?? this.iconS
      ..title = title ?? this.title;
  }
}

PayShops $PayShopsFromJson(Map<String, dynamic> json) {
  final PayShops payShops = PayShops();
  final String? average = jsonConvert.convert<String>(json['average']);
  if (average != null) {
    payShops.average = average;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    payShops.currency = currency;
  }
  final int? hot = jsonConvert.convert<int>(json['hot']);
  if (hot != null) {
    payShops.hot = hot;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    payShops.name = name;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    payShops.price = price;
  }
  final double? priceFvalue = jsonConvert.convert<double>(json['price_fvalue']);
  if (priceFvalue != null) {
    payShops.priceFvalue = priceFvalue;
  }
  final int? priceValue = jsonConvert.convert<int>(json['price_value']);
  if (priceValue != null) {
    payShops.priceValue = priceValue;
  }
  final String? prodId = jsonConvert.convert<String>(json['prod_id']);
  if (prodId != null) {
    payShops.prodId = prodId;
  }
  final String? productType = jsonConvert.convert<String>(json['product_type']);
  if (productType != null) {
    payShops.productType = productType;
  }
  final String? save = jsonConvert.convert<String>(json['save']);
  if (save != null) {
    payShops.save = save;
  }
  final int? subscribing = jsonConvert.convert<int>(json['subscribing']);
  if (subscribing != null) {
    payShops.subscribing = subscribing;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    payShops.time = time;
  }
  final String? uint = jsonConvert.convert<String>(json['uint']);
  if (uint != null) {
    payShops.uint = uint;
  }
  return payShops;
}

Map<String, dynamic> $PayShopsToJson(PayShops entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['average'] = entity.average;
  data['currency'] = entity.currency;
  data['hot'] = entity.hot;
  data['name'] = entity.name;
  data['price'] = entity.price;
  data['price_fvalue'] = entity.priceFvalue;
  data['price_value'] = entity.priceValue;
  data['prod_id'] = entity.prodId;
  data['product_type'] = entity.productType;
  data['save'] = entity.save;
  data['subscribing'] = entity.subscribing;
  data['time'] = entity.time;
  data['uint'] = entity.uint;
  return data;
}

extension PayShopsExtension on PayShops {
  PayShops copyWith({
    String? average,
    String? currency,
    int? hot,
    String? name,
    String? price,
    double? priceFvalue,
    int? priceValue,
    String? prodId,
    String? productType,
    String? save,
    int? subscribing,
    String? time,
    String? uint,
  }) {
    return PayShops()
      ..average = average ?? this.average
      ..currency = currency ?? this.currency
      ..hot = hot ?? this.hot
      ..name = name ?? this.name
      ..price = price ?? this.price
      ..priceFvalue = priceFvalue ?? this.priceFvalue
      ..priceValue = priceValue ?? this.priceValue
      ..prodId = prodId ?? this.prodId
      ..productType = productType ?? this.productType
      ..save = save ?? this.save
      ..subscribing = subscribing ?? this.subscribing
      ..time = time ?? this.time
      ..uint = uint ?? this.uint;
  }
}
