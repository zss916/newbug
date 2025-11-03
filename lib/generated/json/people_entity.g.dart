import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

PeopleEntity $PeopleEntityFromJson(Map<String, dynamic> json) {
  final PeopleEntity peopleEntity = PeopleEntity();
  final int? age = jsonConvert.convert<int>(json['age']);
  if (age != null) {
    peopleEntity.age = age;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    peopleEntity.id = id;
  }
  final int? location = jsonConvert.convert<int>(json['location']);
  if (location != null) {
    peopleEntity.location = location;
  }
  final List<PeopleMediaList>? mediaList =
      (json['media_list'] as List<dynamic>?)
          ?.map(
            (e) => jsonConvert.convert<PeopleMediaList>(e) as PeopleMediaList,
          )
          .toList();
  if (mediaList != null) {
    peopleEntity.mediaList = mediaList;
  }
  final int? nearby = jsonConvert.convert<int>(json['nearby']);
  if (nearby != null) {
    peopleEntity.nearby = nearby;
  }
  final String? nickName = jsonConvert.convert<String>(json['nick_name']);
  if (nickName != null) {
    peopleEntity.nickName = nickName;
  }
  final int? online = jsonConvert.convert<int>(json['online']);
  if (online != null) {
    peopleEntity.online = online;
  }
  final int? read = jsonConvert.convert<int>(json['read']);
  if (read != null) {
    peopleEntity.read = read;
  }
  final String? timeOut = jsonConvert.convert<String>(json['time_out']);
  if (timeOut != null) {
    peopleEntity.timeOut = timeOut;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    peopleEntity.userId = userId;
  }
  final int? viewCount = jsonConvert.convert<int>(json['viewCount']);
  if (viewCount != null) {
    peopleEntity.viewCount = viewCount;
  }
  final String? headimg = jsonConvert.convert<String>(json['headimg']);
  if (headimg != null) {
    peopleEntity.headimg = headimg;
  }
  return peopleEntity;
}

Map<String, dynamic> $PeopleEntityToJson(PeopleEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['age'] = entity.age;
  data['id'] = entity.id;
  data['location'] = entity.location;
  data['media_list'] = entity.mediaList?.map((v) => v.toJson()).toList();
  data['nearby'] = entity.nearby;
  data['nick_name'] = entity.nickName;
  data['online'] = entity.online;
  data['read'] = entity.read;
  data['time_out'] = entity.timeOut;
  data['user_id'] = entity.userId;
  data['viewCount'] = entity.viewCount;
  data['headimg'] = entity.headimg;
  return data;
}

extension PeopleEntityExtension on PeopleEntity {
  PeopleEntity copyWith({
    int? age,
    int? id,
    int? location,
    List<PeopleMediaList>? mediaList,
    int? nearby,
    String? nickName,
    int? online,
    int? read,
    String? timeOut,
    int? userId,
    int? viewCount,
    String? headimg,
  }) {
    return PeopleEntity()
      ..age = age ?? this.age
      ..id = id ?? this.id
      ..location = location ?? this.location
      ..mediaList = mediaList ?? this.mediaList
      ..nearby = nearby ?? this.nearby
      ..nickName = nickName ?? this.nickName
      ..online = online ?? this.online
      ..read = read ?? this.read
      ..timeOut = timeOut ?? this.timeOut
      ..userId = userId ?? this.userId
      ..viewCount = viewCount ?? this.viewCount
      ..headimg = headimg ?? this.headimg;
  }
}

PeopleMediaList $PeopleMediaListFromJson(Map<String, dynamic> json) {
  final PeopleMediaList peopleMediaList = PeopleMediaList();
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    peopleMediaList.duration = duration;
  }
  final int? height = jsonConvert.convert<int>(json['height']);
  if (height != null) {
    peopleMediaList.height = height;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    peopleMediaList.size = size;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    peopleMediaList.type = type;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    peopleMediaList.url = url;
  }
  final int? width = jsonConvert.convert<int>(json['width']);
  if (width != null) {
    peopleMediaList.width = width;
  }
  return peopleMediaList;
}

Map<String, dynamic> $PeopleMediaListToJson(PeopleMediaList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['duration'] = entity.duration;
  data['height'] = entity.height;
  data['size'] = entity.size;
  data['type'] = entity.type;
  data['url'] = entity.url;
  data['width'] = entity.width;
  return data;
}

extension PeopleMediaListExtension on PeopleMediaList {
  PeopleMediaList copyWith({
    int? duration,
    int? height,
    int? size,
    int? type,
    String? url,
    int? width,
  }) {
    return PeopleMediaList()
      ..duration = duration ?? this.duration
      ..height = height ?? this.height
      ..size = size ?? this.size
      ..type = type ?? this.type
      ..url = url ?? this.url
      ..width = width ?? this.width;
  }
}
