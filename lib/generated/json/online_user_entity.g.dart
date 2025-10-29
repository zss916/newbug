import 'package:newbug/core/network/model/online_user_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

OnlineUserEntity $OnlineUserEntityFromJson(Map<String, dynamic> json) {
  final OnlineUserEntity onlineUserEntity = OnlineUserEntity();
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    onlineUserEntity.userId = userId;
  }
  return onlineUserEntity;
}

Map<String, dynamic> $OnlineUserEntityToJson(OnlineUserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user_id'] = entity.userId;
  return data;
}

extension OnlineUserEntityExtension on OnlineUserEntity {
  OnlineUserEntity copyWith({String? userId}) {
    return OnlineUserEntity()..userId = userId ?? this.userId;
  }
}
