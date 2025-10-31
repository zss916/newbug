import 'package:newbug/core/network/model/tag_entity.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/model/user_info.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

UserInfo $UserInfoFromJson(Map<String, dynamic> json) {
  final UserInfo userInfo = UserInfo();
  final UserEntity? user = jsonConvert.convert<UserEntity>(json['user']);
  if (user != null) {
    userInfo.user = user;
  }
  final List<TagEntity>? tagList = (json['tag_list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<TagEntity>(e) as TagEntity)
      .toList();
  if (tagList != null) {
    userInfo.tagList = tagList;
  }
  return userInfo;
}

Map<String, dynamic> $UserInfoToJson(UserInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user'] = entity.user?.toJson();
  data['tag_list'] = entity.tagList?.map((v) => v.toJson()).toList();
  return data;
}

extension UserInfoExtension on UserInfo {
  UserInfo copyWith({UserEntity? user, List<TagEntity>? tagList}) {
    return UserInfo()
      ..user = user ?? this.user
      ..tagList = tagList ?? this.tagList;
  }
}
