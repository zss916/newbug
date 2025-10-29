import 'package:newbug/core/network/model/black_item_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

BlackItemEntity $BlackItemEntityFromJson(Map<String, dynamic> json) {
  final BlackItemEntity blackItemEntity = BlackItemEntity();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    blackItemEntity.userId = userId;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    blackItemEntity.nickName = nickName;
  }
  final String? headimg = jsonConvert.convert<String>(json['headimg']);
  if (headimg != null) {
    blackItemEntity.headimg = headimg;
  }
  final int? online = jsonConvert.convert<int>(json['online']);
  if (online != null) {
    blackItemEntity.online = online;
  }
  final int? isNearBy = jsonConvert.convert<int>(json['isNearBy']);
  if (isNearBy != null) {
    blackItemEntity.isNearBy = isNearBy;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    blackItemEntity.id = id;
  }
  return blackItemEntity;
}

Map<String, dynamic> $BlackItemEntityToJson(BlackItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['nickName'] = entity.nickName;
  data['headimg'] = entity.headimg;
  data['online'] = entity.online;
  data['isNearBy'] = entity.isNearBy;
  data['id'] = entity.id;
  return data;
}

extension BlackItemEntityExtension on BlackItemEntity {
  BlackItemEntity copyWith({
    int? userId,
    String? nickName,
    String? headimg,
    int? online,
    int? isNearBy,
    int? id,
  }) {
    return BlackItemEntity()
      ..userId = userId ?? this.userId
      ..nickName = nickName ?? this.nickName
      ..headimg = headimg ?? this.headimg
      ..online = online ?? this.online
      ..isNearBy = isNearBy ?? this.isNearBy
      ..id = id ?? this.id;
  }
}
