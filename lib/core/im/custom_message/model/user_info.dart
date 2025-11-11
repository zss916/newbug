import 'package:newbug/core/network/model/meida_list_item.dart';

class UserInfo {
  int? userId;
  String? nickName;
  String? headimg;
  String? sign;
  //1男 2女 3非二元
  int? sex;
  int? age;
  int? online;
  int? partyId;
  int? location;
  List<MediaListItem>? mediaList;

  /// 胡须信息
  Map<String, dynamic>? beard_info;

  ///0表示非密友,1表示密友
  int? confidant;

  UserInfo({
    this.userId,
    this.nickName,
    this.headimg,
    this.sign,
    this.sex,
    this.age,
    this.online,
    this.partyId,
    this.location,
    this.confidant,
    this.mediaList,
    this.beard_info,
  });

  UserInfo.fromJson(Map<String, dynamic>? json) {
    userId = json != null && json['user_id'] != null
        ? parseUserId(json['user_id'])
        : null;
    nickName = json?['nick_name'];
    headimg = json?['headimg'];
    sign = json?['sign'];
    sex = json?['sexual'];
    age = json?['age'];
    online = json?['online'];
    partyId = json?['party_id'];
    location = json?['location'];
    confidant = json?['confidant'];
    if (json?['media_list'] != null) {
      mediaList = <MediaListItem>[];
      json?['media_list']?.forEach((v) {
        mediaList!.add(MediaListItem.fromJson(v));
      });
    }
    beard_info = json?['beard_info'];
  }

  int parseUserId(dynamic userId) {
    if (userId is String) {
      if (userId.isEmpty) {
        return 0; // 或者你可以选择抛出一个异常
      }
      return int.parse(userId);
    } else if (userId is int) {
      return userId;
    } else {
      throw FormatException("Invalid user_id format");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['nick_name'] = nickName;
    data['headimg'] = headimg;
    data['sign'] = sign;
    data['sexual'] = sex;
    data['age'] = age;
    data['online'] = online;
    data['party_id'] = partyId;
    data['location'] = location;
    data['confidant'] = confidant;
    if (mediaList != null) {
      data['media_list'] = mediaList!.map((v) => v.toJson()).toList();
    }
    if (beard_info != null) {
      data['beard_info'] = beard_info;
    }
    return data;
  }
}
