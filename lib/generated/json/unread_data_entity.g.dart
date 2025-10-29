import 'package:newbug/core/network/model/unread_data_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

UnreadDataEntity $UnreadDataEntityFromJson(Map<String, dynamic> json) {
  final UnreadDataEntity unreadDataEntity = UnreadDataEntity();
  final List<String>? headList = (json['head_list'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (headList != null) {
    unreadDataEntity.headList = headList;
  }
  final int? visitorNewNum = jsonConvert.convert<int>(json['visitor_new_num']);
  if (visitorNewNum != null) {
    unreadDataEntity.visitorNewNum = visitorNewNum;
  }
  final int? visitorTotalNum = jsonConvert.convert<int>(
    json['visitor_total_num'],
  );
  if (visitorTotalNum != null) {
    unreadDataEntity.visitorTotalNum = visitorTotalNum;
  }
  final int? wlmNewNum = jsonConvert.convert<int>(json['wlm_new_num']);
  if (wlmNewNum != null) {
    unreadDataEntity.wlmNewNum = wlmNewNum;
  }
  final int? wlmTotalNum = jsonConvert.convert<int>(json['wlm_total_num']);
  if (wlmTotalNum != null) {
    unreadDataEntity.wlmTotalNum = wlmTotalNum;
  }
  final String? likesAvatar = jsonConvert.convert<String>(json['likes_avatar']);
  if (likesAvatar != null) {
    unreadDataEntity.likesAvatar = likesAvatar;
  }
  final String? visitorAvatar = jsonConvert.convert<String>(
    json['visitor_avatar'],
  );
  if (visitorAvatar != null) {
    unreadDataEntity.visitorAvatar = visitorAvatar;
  }
  return unreadDataEntity;
}

Map<String, dynamic> $UnreadDataEntityToJson(UnreadDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['head_list'] = entity.headList;
  data['visitor_new_num'] = entity.visitorNewNum;
  data['visitor_total_num'] = entity.visitorTotalNum;
  data['wlm_new_num'] = entity.wlmNewNum;
  data['wlm_total_num'] = entity.wlmTotalNum;
  data['likes_avatar'] = entity.likesAvatar;
  data['visitor_avatar'] = entity.visitorAvatar;
  return data;
}

extension UnreadDataEntityExtension on UnreadDataEntity {
  UnreadDataEntity copyWith({
    List<String>? headList,
    int? visitorNewNum,
    int? visitorTotalNum,
    int? wlmNewNum,
    int? wlmTotalNum,
    String? likesAvatar,
    String? visitorAvatar,
  }) {
    return UnreadDataEntity()
      ..headList = headList ?? this.headList
      ..visitorNewNum = visitorNewNum ?? this.visitorNewNum
      ..visitorTotalNum = visitorTotalNum ?? this.visitorTotalNum
      ..wlmNewNum = wlmNewNum ?? this.wlmNewNum
      ..wlmTotalNum = wlmTotalNum ?? this.wlmTotalNum
      ..likesAvatar = likesAvatar ?? this.likesAvatar
      ..visitorAvatar = visitorAvatar ?? this.visitorAvatar;
  }
}
