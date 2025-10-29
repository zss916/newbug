import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/model/user_info.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

UserInfo $UserInfoFromJson(Map<String, dynamic> json) {
  final UserInfo userInfo = UserInfo();
  final UserEntity? user = jsonConvert.convert<UserEntity>(json['user']);
  if (user != null) {
    userInfo.user = user;
  }
  return userInfo;
}

Map<String, dynamic> $UserInfoToJson(UserInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user'] = entity.user?.toJson();
  return data;
}

extension UserInfoExtension on UserInfo {
  UserInfo copyWith({UserEntity? user, Object? tagList}) {
    return UserInfo()
      ..user = user ?? this.user
      ..tagList = tagList ?? this.tagList;
  }
}
