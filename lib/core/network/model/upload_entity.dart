import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/upload_entity.g.dart';

export 'package:newbug/generated/json/upload_entity.g.dart';

@JsonSerializable()
class UploadEntity {
  @JSONField(name: 'cdn_url')
  String? cdnUrl;
  @JSONField(name: 'file_name')
  String? fileName;
  @JSONField(name: 'upload_url')
  String? uploadUrl;

  UploadEntity();

  factory UploadEntity.fromJson(Map<String, dynamic> json) =>
      $UploadEntityFromJson(json);

  Map<String, dynamic> toJson() => $UploadEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
