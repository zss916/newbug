import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/unread_data_entity.g.dart';

export 'package:newbug/generated/json/unread_data_entity.g.dart';

@JsonSerializable()
class UnreadDataEntity {
  @JSONField(name: 'head_list')
  List<String>? headList;
  @JSONField(name: 'visitor_new_num')
  int? visitorNewNum;
  @JSONField(name: 'visitor_total_num')
  int? visitorTotalNum;
  @JSONField(name: 'wlm_new_num')
  int? wlmNewNum;
  @JSONField(name: 'wlm_total_num')
  int? wlmTotalNum;
  @JSONField(name: 'likes_avatar')
  String? likesAvatar;
  @JSONField(name: 'visitor_avatar')
  String? visitorAvatar;

  UnreadDataEntity();

  factory UnreadDataEntity.fromJson(Map<String, dynamic> json) =>
      $UnreadDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $UnreadDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
