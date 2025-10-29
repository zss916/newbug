import 'package:newbug/core/network/model/upload_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

UploadEntity $UploadEntityFromJson(Map<String, dynamic> json) {
  final UploadEntity uploadEntity = UploadEntity();
  final String? cdnUrl = jsonConvert.convert<String>(json['cdn_url']);
  if (cdnUrl != null) {
    uploadEntity.cdnUrl = cdnUrl;
  }
  final String? fileName = jsonConvert.convert<String>(json['file_name']);
  if (fileName != null) {
    uploadEntity.fileName = fileName;
  }
  final String? uploadUrl = jsonConvert.convert<String>(json['upload_url']);
  if (uploadUrl != null) {
    uploadEntity.uploadUrl = uploadUrl;
  }
  return uploadEntity;
}

Map<String, dynamic> $UploadEntityToJson(UploadEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cdn_url'] = entity.cdnUrl;
  data['file_name'] = entity.fileName;
  data['upload_url'] = entity.uploadUrl;
  return data;
}

extension UploadEntityExtension on UploadEntity {
  UploadEntity copyWith({String? cdnUrl, String? fileName, String? uploadUrl}) {
    return UploadEntity()
      ..cdnUrl = cdnUrl ?? this.cdnUrl
      ..fileName = fileName ?? this.fileName
      ..uploadUrl = uploadUrl ?? this.uploadUrl;
  }
}
