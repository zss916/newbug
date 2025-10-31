import 'package:newbug/core/network/model/tag_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

TagEntity $TagEntityFromJson(Map<String, dynamic> json) {
  final TagEntity tagEntity = TagEntity();
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    tagEntity.desc = desc;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    tagEntity.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    tagEntity.title = title;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    tagEntity.type = type;
  }
  final bool? isSelected = jsonConvert.convert<bool>(json['isSelected']);
  if (isSelected != null) {
    tagEntity.isSelected = isSelected;
  }
  return tagEntity;
}

Map<String, dynamic> $TagEntityToJson(TagEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['desc'] = entity.desc;
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['type'] = entity.type;
  data['isSelected'] = entity.isSelected;
  return data;
}

extension TagEntityExtension on TagEntity {
  TagEntity copyWith({
    String? desc,
    int? id,
    String? title,
    int? type,
    bool? isSelected,
  }) {
    return TagEntity()
      ..desc = desc ?? this.desc
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..type = type ?? this.type
      ..isSelected = isSelected ?? this.isSelected;
  }
}
