import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/private_msg_status_entity.g.dart';

export 'package:newbug/generated/json/private_msg_status_entity.g.dart';

@JsonSerializable()
class PrivateMsgStatusEntity {
  //销毁倒计时
  @JSONField(name: 'del_time')
  int? delTime;
  //是否手动刷新融云扩展信息 0不手动 1手动
  @JSONField(name: 'set_ext')
  int? setExt;
  //0 失败 1 成功
  int? status;

  PrivateMsgStatusEntity();

  factory PrivateMsgStatusEntity.fromJson(Map<String, dynamic> json) =>
      $PrivateMsgStatusEntityFromJson(json);

  Map<String, dynamic> toJson() => $PrivateMsgStatusEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
