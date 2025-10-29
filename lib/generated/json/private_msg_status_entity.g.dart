import 'package:newbug/core/network/model/private_msg_status_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

PrivateMsgStatusEntity $PrivateMsgStatusEntityFromJson(
  Map<String, dynamic> json,
) {
  final PrivateMsgStatusEntity privateMsgStatusEntity =
      PrivateMsgStatusEntity();
  final int? delTime = jsonConvert.convert<int>(json['del_time']);
  if (delTime != null) {
    privateMsgStatusEntity.delTime = delTime;
  }
  final int? setExt = jsonConvert.convert<int>(json['set_ext']);
  if (setExt != null) {
    privateMsgStatusEntity.setExt = setExt;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    privateMsgStatusEntity.status = status;
  }
  return privateMsgStatusEntity;
}

Map<String, dynamic> $PrivateMsgStatusEntityToJson(
  PrivateMsgStatusEntity entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['del_time'] = entity.delTime;
  data['set_ext'] = entity.setExt;
  data['status'] = entity.status;
  return data;
}

extension PrivateMsgStatusEntityExtension on PrivateMsgStatusEntity {
  PrivateMsgStatusEntity copyWith({int? delTime, int? setExt, int? status}) {
    return PrivateMsgStatusEntity()
      ..delTime = delTime ?? this.delTime
      ..setExt = setExt ?? this.setExt
      ..status = status ?? this.status;
  }
}
