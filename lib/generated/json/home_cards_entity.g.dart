import 'package:newbug/core/network/model/home_cards_entity.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

HomeCardsEntity $HomeCardsEntityFromJson(Map<String, dynamic> json) {
  final HomeCardsEntity homeCardsEntity = HomeCardsEntity();
  final List<HomeCardsMatchList>? matchList =
      (json['match_list'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<HomeCardsMatchList>(e)
                    as HomeCardsMatchList,
          )
          .toList();
  if (matchList != null) {
    homeCardsEntity.matchList = matchList;
  }
  final List<String>? privacyList = (json['privacy_list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (privacyList != null) {
    homeCardsEntity.privacyList = privacyList;
  }
  final Right? rights = jsonConvert.convert<Right>(json['rights']);
  if (rights != null) {
    homeCardsEntity.rights = rights;
  }
  return homeCardsEntity;
}

Map<String, dynamic> $HomeCardsEntityToJson(HomeCardsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['match_list'] = entity.matchList?.map((v) => v.toJson()).toList();
  data['privacy_list'] = entity.privacyList;
  data['rights'] = entity.rights?.toJson();
  return data;
}

extension HomeCardsEntityExtension on HomeCardsEntity {
  HomeCardsEntity copyWith({
    List<HomeCardsMatchList>? matchList,
    List<String>? privacyList,
    Right? rights,
  }) {
    return HomeCardsEntity()
      ..matchList = matchList ?? this.matchList
      ..privacyList = privacyList ?? this.privacyList
      ..rights = rights ?? this.rights;
  }
}

HomeCardsMatchList $HomeCardsMatchListFromJson(Map<String, dynamic> json) {
  final HomeCardsMatchList homeCardsMatchList = HomeCardsMatchList();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    homeCardsMatchList.id = id;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    homeCardsMatchList.address = address;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    homeCardsMatchList.age = age;
  }
  final String? headimg = jsonConvert.convert<String>(json['headimg']);
  if (headimg != null) {
    homeCardsMatchList.headimg = headimg;
  }
  final int? location = jsonConvert.convert<int>(json['location']);
  if (location != null) {
    homeCardsMatchList.location = location;
  }
  final List<MediaListItem>? mediaList = (json['media_list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MediaListItem>(e) as MediaListItem)
      .toList();
  if (mediaList != null) {
    homeCardsMatchList.mediaList = mediaList;
  }
  final String? nickName = jsonConvert.convert<String>(json['nick_name']);
  if (nickName != null) {
    homeCardsMatchList.nickName = nickName;
  }
  final int? online = jsonConvert.convert<int>(json['online']);
  if (online != null) {
    homeCardsMatchList.online = online;
  }
  final int? reviewing = jsonConvert.convert<int>(json['reviewing']);
  if (reviewing != null) {
    homeCardsMatchList.reviewing = reviewing;
  }
  final String? sInfo = jsonConvert.convert<String>(json['s_info']);
  if (sInfo != null) {
    homeCardsMatchList.sInfo = sInfo;
  }
  final String? sign = jsonConvert.convert<String>(json['sign']);
  if (sign != null) {
    homeCardsMatchList.sign = sign;
  }
  final String? sticker = jsonConvert.convert<String>(json['sticker']);
  if (sticker != null) {
    homeCardsMatchList.sticker = sticker;
  }
  final List<String>? tags = (json['tags'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (tags != null) {
    homeCardsMatchList.tags = tags;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    homeCardsMatchList.type = type;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    homeCardsMatchList.userId = userId;
  }
  final bool? follow = jsonConvert.convert<bool>(json['follow']);
  if (follow != null) {
    homeCardsMatchList.follow = follow;
  }
  final bool? isFriend = jsonConvert.convert<bool>(json['isFriend']);
  if (isFriend != null) {
    homeCardsMatchList.isFriend = isFriend;
  }
  final bool? hasSendFc = jsonConvert.convert<bool>(json['hasSendFc']);
  if (hasSendFc != null) {
    homeCardsMatchList.hasSendFc = hasSendFc;
  }
  final bool? passLoading = jsonConvert.convert<bool>(json['passLoading']);
  if (passLoading != null) {
    homeCardsMatchList.passLoading = passLoading;
  }
  final bool? likeLoading = jsonConvert.convert<bool>(json['likeLoading']);
  if (likeLoading != null) {
    homeCardsMatchList.likeLoading = likeLoading;
  }
  final bool? isSwiped = jsonConvert.convert<bool>(json['isSwiped']);
  if (isSwiped != null) {
    homeCardsMatchList.isSwiped = isSwiped;
  }
  return homeCardsMatchList;
}

Map<String, dynamic> $HomeCardsMatchListToJson(HomeCardsMatchList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['address'] = entity.address;
  data['age'] = entity.age;
  data['headimg'] = entity.headimg;
  data['location'] = entity.location;
  data['media_list'] = entity.mediaList?.map((v) => v.toJson()).toList();
  data['nick_name'] = entity.nickName;
  data['online'] = entity.online;
  data['reviewing'] = entity.reviewing;
  data['s_info'] = entity.sInfo;
  data['sign'] = entity.sign;
  data['sticker'] = entity.sticker;
  data['tags'] = entity.tags;
  data['type'] = entity.type;
  data['user_id'] = entity.userId;
  data['follow'] = entity.follow;
  data['isFriend'] = entity.isFriend;
  data['hasSendFc'] = entity.hasSendFc;
  data['passLoading'] = entity.passLoading;
  data['likeLoading'] = entity.likeLoading;
  data['isSwiped'] = entity.isSwiped;
  return data;
}

extension HomeCardsMatchListExtension on HomeCardsMatchList {
  HomeCardsMatchList copyWith({
    int? id,
    String? address,
    int? age,
    String? headimg,
    int? location,
    List<MediaListItem>? mediaList,
    String? nickName,
    int? online,
    int? reviewing,
    String? sInfo,
    String? sign,
    String? sticker,
    List<String>? tags,
    int? type,
    int? userId,
    bool? follow,
    bool? isFriend,
    bool? hasSendFc,
    bool? passLoading,
    bool? likeLoading,
    bool? isSwiped,
  }) {
    return HomeCardsMatchList()
      ..id = id ?? this.id
      ..address = address ?? this.address
      ..age = age ?? this.age
      ..headimg = headimg ?? this.headimg
      ..location = location ?? this.location
      ..mediaList = mediaList ?? this.mediaList
      ..nickName = nickName ?? this.nickName
      ..online = online ?? this.online
      ..reviewing = reviewing ?? this.reviewing
      ..sInfo = sInfo ?? this.sInfo
      ..sign = sign ?? this.sign
      ..sticker = sticker ?? this.sticker
      ..tags = tags ?? this.tags
      ..type = type ?? this.type
      ..userId = userId ?? this.userId
      ..follow = follow ?? this.follow
      ..isFriend = isFriend ?? this.isFriend
      ..hasSendFc = hasSendFc ?? this.hasSendFc
      ..passLoading = passLoading ?? this.passLoading
      ..likeLoading = likeLoading ?? this.likeLoading
      ..isSwiped = isSwiped ?? this.isSwiped;
  }
}
