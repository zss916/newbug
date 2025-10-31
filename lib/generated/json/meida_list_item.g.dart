import 'dart:io';

import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

MediaListItem $MediaListItemFromJson(Map<String, dynamic> json) {
  final MediaListItem mediaListItem = MediaListItem();
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    mediaListItem.type = type;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    mediaListItem.id = id;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    mediaListItem.url = url;
  }
  final int? width = jsonConvert.convert<int>(json['width']);
  if (width != null) {
    mediaListItem.width = width;
  }
  final int? height = jsonConvert.convert<int>(json['height']);
  if (height != null) {
    mediaListItem.height = height;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    mediaListItem.size = size;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    mediaListItem.duration = duration;
  }
  final int? isPrivate = jsonConvert.convert<int>(json['is_private']);
  if (isPrivate != null) {
    mediaListItem.isPrivate = isPrivate;
  }
  final String? thumbUrl = jsonConvert.convert<String>(json['thumbUrl']);
  if (thumbUrl != null) {
    mediaListItem.thumbUrl = thumbUrl;
  }
  final String? localFilePath = jsonConvert.convert<String>(
    json['localFilePath'],
  );
  if (localFilePath != null) {
    mediaListItem.localFilePath = localFilePath;
  }
  final bool? isSelected = jsonConvert.convert<bool>(json['isSelected']);
  if (isSelected != null) {
    mediaListItem.isSelected = isSelected;
  }
  final int? selectedIndex = jsonConvert.convert<int>(json['selectedIndex']);
  if (selectedIndex != null) {
    mediaListItem.selectedIndex = selectedIndex;
  }
  return mediaListItem;
}

Map<String, dynamic> $MediaListItemToJson(MediaListItem entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['type'] = entity.type;
  data['id'] = entity.id;
  data['url'] = entity.url;
  data['width'] = entity.width;
  data['height'] = entity.height;
  data['size'] = entity.size;
  data['duration'] = entity.duration;
  data['is_private'] = entity.isPrivate;
  data['thumbUrl'] = entity.thumbUrl;
  data['localFilePath'] = entity.localFilePath;
  data['isSelected'] = entity.isSelected;
  data['selectedIndex'] = entity.selectedIndex;
  return data;
}

extension MediaListItemExtension on MediaListItem {
  MediaListItem copyWith({
    int? type,
    int? id,
    String? url,
    int? width,
    int? height,
    int? size,
    int? duration,
    int? isPrivate,
    String? thumbUrl,
    File? localFile,
    String? localFilePath,
    bool? isSelected,
    int? selectedIndex,
  }) {
    return MediaListItem()
      ..type = type ?? this.type
      ..id = id ?? this.id
      ..url = url ?? this.url
      ..width = width ?? this.width
      ..height = height ?? this.height
      ..size = size ?? this.size
      ..duration = duration ?? this.duration
      ..isPrivate = isPrivate ?? this.isPrivate
      ..thumbUrl = thumbUrl ?? this.thumbUrl
      ..localFile = localFile ?? this.localFile
      ..localFilePath = localFilePath ?? this.localFilePath
      ..isSelected = isSelected ?? this.isSelected
      ..selectedIndex = selectedIndex ?? this.selectedIndex;
  }
}
