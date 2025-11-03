import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/right.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
  final UserEntity userEntity = UserEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userEntity.id = id;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    userEntity.userId = userId;
  }
  final String? authToken = jsonConvert.convert<String>(json['auth_token']);
  if (authToken != null) {
    userEntity.authToken = authToken;
  }
  final String? imToken = jsonConvert.convert<String>(json['im_token']);
  if (imToken != null) {
    userEntity.imToken = imToken;
  }
  final int? expireAt = jsonConvert.convert<int>(json['expire_at']);
  if (expireAt != null) {
    userEntity.expireAt = expireAt;
  }
  final String? nickName = jsonConvert.convert<String>(json['nick_name']);
  if (nickName != null) {
    userEntity.nickName = nickName;
  }
  final String? headimg = jsonConvert.convert<String>(json['headimg']);
  if (headimg != null) {
    userEntity.headimg = headimg;
  }
  final int? isNewUser = jsonConvert.convert<int>(json['is_new_user']);
  if (isNewUser != null) {
    userEntity.isNewUser = isNewUser;
  }
  final String? sign = jsonConvert.convert<String>(json['sign']);
  if (sign != null) {
    userEntity.sign = sign;
  }
  final int? sexuality = jsonConvert.convert<int>(json['sexuality']);
  if (sexuality != null) {
    userEntity.sexuality = sexuality;
  }
  final int? sex = jsonConvert.convert<int>(json['sex']);
  if (sex != null) {
    userEntity.sex = sex;
  }
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    userEntity.age = age;
  }
  final int? isHide = jsonConvert.convert<int>(json['is_hide']);
  if (isHide != null) {
    userEntity.isHide = isHide;
  }
  final int? block = jsonConvert.convert<int>(json['block']);
  if (block != null) {
    userEntity.block = block;
  }
  final int? online = jsonConvert.convert<int>(json['online']);
  if (online != null) {
    userEntity.online = online;
  }
  final int? brithday = jsonConvert.convert<int>(json['brithday']);
  if (brithday != null) {
    userEntity.brithday = brithday;
  }
  final int? location = jsonConvert.convert<int>(json['location']);
  if (location != null) {
    userEntity.location = location;
  }
  final List<MediaListItem>? mediaList = (json['media_list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MediaListItem>(e) as MediaListItem)
      .toList();
  if (mediaList != null) {
    userEntity.mediaList = mediaList;
  }
  final List<String>? tags = (json['tags'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (tags != null) {
    userEntity.tags = tags;
  }
  final List<String>? desires = (json['desires'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (desires != null) {
    userEntity.desires = desires;
  }
  final int? pushConfig = jsonConvert.convert<int>(json['push_config']);
  if (pushConfig != null) {
    userEntity.pushConfig = pushConfig;
  }
  final Right? right = jsonConvert.convert<Right>(json['right']);
  if (right != null) {
    userEntity.right = right;
  }
  final bool? isTodaySign = jsonConvert.convert<bool>(json['is_today_sign']);
  if (isTodaySign != null) {
    userEntity.isTodaySign = isTodaySign;
  }
  final int? refer = jsonConvert.convert<int>(json['refer']);
  if (refer != null) {
    userEntity.refer = refer;
  }
  final int? role = jsonConvert.convert<int>(json['role']);
  if (role != null) {
    userEntity.role = role;
  }
  final int? confidant = jsonConvert.convert<int>(json['confidant']);
  if (confidant != null) {
    userEntity.confidant = confidant;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    userEntity.msg = msg;
  }
  final List<PartyItem>? parties = (json['parties'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<PartyItem>(e) as PartyItem)
      .toList();
  if (parties != null) {
    userEntity.parties = parties;
  }
  final PartyItem? party = jsonConvert.convert<PartyItem>(json['party']);
  if (party != null) {
    userEntity.party = party;
  }
  final int? partyId = jsonConvert.convert<int>(json['partyId']);
  if (partyId != null) {
    userEntity.partyId = partyId;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    userEntity.address = address;
  }
  final String? waUrl = jsonConvert.convert<String>(json['waUrl']);
  if (waUrl != null) {
    userEntity.waUrl = waUrl;
  }
  final int? scene = jsonConvert.convert<int>(json['scene']);
  if (scene != null) {
    userEntity.scene = scene;
  }
  final BeardInfoType? beardInfo = jsonConvert.convert<BeardInfoType>(
    json['beard_info'],
  );
  if (beardInfo != null) {
    userEntity.beardInfo = beardInfo;
  }
  final bool? follow = jsonConvert.convert<bool>(json['follow']);
  if (follow != null) {
    userEntity.follow = follow;
  }
  final bool? followMe = jsonConvert.convert<bool>(json['follow_me']);
  if (followMe != null) {
    userEntity.followMe = followMe;
  }
  final bool? isFriend = jsonConvert.convert<bool>(json['isFriend']);
  if (isFriend != null) {
    userEntity.isFriend = isFriend;
  }
  final List<MomentListModel>? momentList =
      (json['moment_list'] as List<dynamic>?)
          ?.map(
            (e) => jsonConvert.convert<MomentListModel>(e) as MomentListModel,
          )
          .toList();
  if (momentList != null) {
    userEntity.momentList = momentList;
  }
  return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['user_id'] = entity.userId;
  data['auth_token'] = entity.authToken;
  data['im_token'] = entity.imToken;
  data['expire_at'] = entity.expireAt;
  data['nick_name'] = entity.nickName;
  data['headimg'] = entity.headimg;
  data['is_new_user'] = entity.isNewUser;
  data['sign'] = entity.sign;
  data['sexuality'] = entity.sexuality;
  data['sex'] = entity.sex;
  data['age'] = entity.age;
  data['is_hide'] = entity.isHide;
  data['block'] = entity.block;
  data['online'] = entity.online;
  data['brithday'] = entity.brithday;
  data['location'] = entity.location;
  data['media_list'] = entity.mediaList?.map((v) => v.toJson()).toList();
  data['tags'] = entity.tags;
  data['desires'] = entity.desires;
  data['push_config'] = entity.pushConfig;
  data['right'] = entity.right?.toJson();
  data['is_today_sign'] = entity.isTodaySign;
  data['refer'] = entity.refer;
  data['role'] = entity.role;
  data['confidant'] = entity.confidant;
  data['msg'] = entity.msg;
  data['parties'] = entity.parties?.map((v) => v.toJson()).toList();
  data['party'] = entity.party?.toJson();
  data['partyId'] = entity.partyId;
  data['address'] = entity.address;
  data['waUrl'] = entity.waUrl;
  data['scene'] = entity.scene;
  data['beard_info'] = entity.beardInfo?.toJson();
  data['follow'] = entity.follow;
  data['follow_me'] = entity.followMe;
  data['isFriend'] = entity.isFriend;
  data['moment_list'] = entity.momentList?.map((v) => v.toJson()).toList();
  return data;
}

extension UserEntityExtension on UserEntity {
  UserEntity copyWith({
    int? id,
    String? userId,
    String? authToken,
    String? imToken,
    int? expireAt,
    String? nickName,
    String? headimg,
    int? isNewUser,
    String? sign,
    int? sexuality,
    int? sex,
    int? age,
    int? isHide,
    int? block,
    int? online,
    int? brithday,
    int? location,
    List<MediaListItem>? mediaList,
    List<String>? tags,
    List<String>? desires,
    int? pushConfig,
    Right? right,
    bool? isTodaySign,
    int? refer,
    int? role,
    int? confidant,
    String? msg,
    List<PartyItem>? parties,
    PartyItem? party,
    int? partyId,
    String? address,
    String? waUrl,
    int? scene,
    BeardInfoType? beardInfo,
    bool? follow,
    bool? followMe,
    bool? isFriend,
    List<MomentListModel>? momentList,
  }) {
    return UserEntity()
      ..id = id ?? this.id
      ..userId = userId ?? this.userId
      ..authToken = authToken ?? this.authToken
      ..imToken = imToken ?? this.imToken
      ..expireAt = expireAt ?? this.expireAt
      ..nickName = nickName ?? this.nickName
      ..headimg = headimg ?? this.headimg
      ..isNewUser = isNewUser ?? this.isNewUser
      ..sign = sign ?? this.sign
      ..sexuality = sexuality ?? this.sexuality
      ..sex = sex ?? this.sex
      ..age = age ?? this.age
      ..isHide = isHide ?? this.isHide
      ..block = block ?? this.block
      ..online = online ?? this.online
      ..brithday = brithday ?? this.brithday
      ..location = location ?? this.location
      ..mediaList = mediaList ?? this.mediaList
      ..tags = tags ?? this.tags
      ..desires = desires ?? this.desires
      ..pushConfig = pushConfig ?? this.pushConfig
      ..right = right ?? this.right
      ..isTodaySign = isTodaySign ?? this.isTodaySign
      ..refer = refer ?? this.refer
      ..role = role ?? this.role
      ..confidant = confidant ?? this.confidant
      ..msg = msg ?? this.msg
      ..parties = parties ?? this.parties
      ..party = party ?? this.party
      ..partyId = partyId ?? this.partyId
      ..address = address ?? this.address
      ..waUrl = waUrl ?? this.waUrl
      ..scene = scene ?? this.scene
      ..beardInfo = beardInfo ?? this.beardInfo
      ..follow = follow ?? this.follow
      ..followMe = followMe ?? this.followMe
      ..isFriend = isFriend ?? this.isFriend
      ..momentList = momentList ?? this.momentList;
  }
}

PartyItem $PartyItemFromJson(Map<String, dynamic> json) {
  final PartyItem partyItem = PartyItem();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    partyItem.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    partyItem.name = name;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    partyItem.city = city;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    partyItem.location = location;
  }
  final String? coverImg = jsonConvert.convert<String>(json['coverImg']);
  if (coverImg != null) {
    partyItem.coverImg = coverImg;
  }
  final int? partyTime = jsonConvert.convert<int>(json['partyTime']);
  if (partyTime != null) {
    partyItem.partyTime = partyTime;
  }
  final int? member = jsonConvert.convert<int>(json['member']);
  if (member != null) {
    partyItem.member = member;
  }
  final int? memberNum = jsonConvert.convert<int>(json['memberNum']);
  if (memberNum != null) {
    partyItem.memberNum = memberNum;
  }
  final List<Members>? members = (json['members'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<Members>(e) as Members)
      .toList();
  if (members != null) {
    partyItem.members = members;
  }
  return partyItem;
}

Map<String, dynamic> $PartyItemToJson(PartyItem entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['city'] = entity.city;
  data['location'] = entity.location;
  data['coverImg'] = entity.coverImg;
  data['partyTime'] = entity.partyTime;
  data['member'] = entity.member;
  data['memberNum'] = entity.memberNum;
  data['members'] = entity.members?.map((v) => v.toJson()).toList();
  return data;
}

extension PartyItemExtension on PartyItem {
  PartyItem copyWith({
    int? id,
    String? name,
    String? city,
    String? location,
    String? coverImg,
    int? partyTime,
    int? member,
    int? memberNum,
    List<Members>? members,
  }) {
    return PartyItem()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..city = city ?? this.city
      ..location = location ?? this.location
      ..coverImg = coverImg ?? this.coverImg
      ..partyTime = partyTime ?? this.partyTime
      ..member = member ?? this.member
      ..memberNum = memberNum ?? this.memberNum
      ..members = members ?? this.members;
  }
}

Members $MembersFromJson(Map<String, dynamic> json) {
  final Members members = Members();
  final String? headimg = jsonConvert.convert<String>(json['headimg']);
  if (headimg != null) {
    members.headimg = headimg;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    members.nickName = nickName;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    members.userId = userId;
  }
  return members;
}

Map<String, dynamic> $MembersToJson(Members entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['headimg'] = entity.headimg;
  data['nickName'] = entity.nickName;
  data['userId'] = entity.userId;
  return data;
}

extension MembersExtension on Members {
  Members copyWith({String? headimg, String? nickName, int? userId}) {
    return Members()
      ..headimg = headimg ?? this.headimg
      ..nickName = nickName ?? this.nickName
      ..userId = userId ?? this.userId;
  }
}

BeardInfoType $BeardInfoTypeFromJson(Map<String, dynamic> json) {
  final BeardInfoType beardInfoType = BeardInfoType();
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    beardInfoType.country = country;
  }
  final List<BeardType>? beards = (json['beards'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<BeardType>(e) as BeardType)
      .toList();
  if (beards != null) {
    beardInfoType.beards = beards;
  }
  return beardInfoType;
}

Map<String, dynamic> $BeardInfoTypeToJson(BeardInfoType entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['country'] = entity.country;
  data['beards'] = entity.beards?.map((v) => v.toJson()).toList();
  return data;
}

extension BeardInfoTypeExtension on BeardInfoType {
  BeardInfoType copyWith({String? country, List<BeardType>? beards}) {
    return BeardInfoType()
      ..country = country ?? this.country
      ..beards = beards ?? this.beards;
  }
}

BeardType $BeardTypeFromJson(Map<String, dynamic> json) {
  final BeardType beardType = BeardType();
  final int? beard = jsonConvert.convert<int>(json['beard']);
  if (beard != null) {
    beardType.beard = beard;
  }
  final String? beardName = jsonConvert.convert<String>(json['beard_name']);
  if (beardName != null) {
    beardType.beardName = beardName;
  }
  return beardType;
}

Map<String, dynamic> $BeardTypeToJson(BeardType entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['beard'] = entity.beard;
  data['beard_name'] = entity.beardName;
  return data;
}

extension BeardTypeExtension on BeardType {
  BeardType copyWith({int? beard, String? beardName}) {
    return BeardType()
      ..beard = beard ?? this.beard
      ..beardName = beardName ?? this.beardName;
  }
}

MomentListModel $MomentListModelFromJson(Map<String, dynamic> json) {
  final MomentListModel momentListModel = MomentListModel();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    momentListModel.id = id;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    momentListModel.userId = userId;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    momentListModel.nickName = nickName;
  }
  final String? headimg = jsonConvert.convert<String>(json['headimg']);
  if (headimg != null) {
    momentListModel.headimg = headimg;
  }
  final int? follow = jsonConvert.convert<int>(json['follow']);
  if (follow != null) {
    momentListModel.follow = follow;
  }
  final int? isFriend = jsonConvert.convert<int>(json['isFriend']);
  if (isFriend != null) {
    momentListModel.isFriend = isFriend;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    momentListModel.country = country;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    momentListModel.content = content;
  }
  final List<MediaListItem>? media = (json['media'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MediaListItem>(e) as MediaListItem)
      .toList();
  if (media != null) {
    momentListModel.media = media;
  }
  return momentListModel;
}

Map<String, dynamic> $MomentListModelToJson(MomentListModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['userId'] = entity.userId;
  data['nickName'] = entity.nickName;
  data['headimg'] = entity.headimg;
  data['follow'] = entity.follow;
  data['isFriend'] = entity.isFriend;
  data['country'] = entity.country;
  data['content'] = entity.content;
  data['media'] = entity.media?.map((v) => v.toJson()).toList();
  return data;
}

extension MomentListModelExtension on MomentListModel {
  MomentListModel copyWith({
    int? id,
    int? userId,
    String? nickName,
    String? headimg,
    int? follow,
    int? isFriend,
    String? country,
    String? content,
    List<MediaListItem>? media,
  }) {
    return MomentListModel()
      ..id = id ?? this.id
      ..userId = userId ?? this.userId
      ..nickName = nickName ?? this.nickName
      ..headimg = headimg ?? this.headimg
      ..follow = follow ?? this.follow
      ..isFriend = isFriend ?? this.isFriend
      ..country = country ?? this.country
      ..content = content ?? this.content
      ..media = media ?? this.media;
  }
}
