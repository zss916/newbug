import 'dart:convert';
import 'dart:io';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/meida_list_item.g.dart';

@JsonSerializable()
class MediaListItem {
  ///0图片 1视频
  int? type;
  int? id;
  String? url;
  int? width;
  int? height;
  int? size;
  int? duration;

  /// 是否是私密图片 1 是 0 否
  @JSONField(name: 'is_private')
  int? isPrivate;

  ///缩略图(本地维护)
  String? thumbUrl;

  ///用于本地选择的图片
  @JSONField(serialize: false, deserialize: false)
  File? localFile;

  ///本地图片路径
  String? localFilePath;

  ///用户package确认页是否选中
  bool isSelected = true;

  /// 私密相册中的媒体选择展示的数字标签
  int? selectedIndex;

  MediaListItem();

  factory MediaListItem.fromJson(Map<String, dynamic> json) =>
      $MediaListItemFromJson(json);

  Map<String, dynamic> toJson() => $MediaListItemToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  /// 是否是视频
  bool get isVideo => type == 1;

  /// 是否是私密图片
  bool get isPrivateMedia => isPrivate == 1;

  /// 获取图片或者视频封面图片
  String get imageUrl => isVideo ? (thumbUrl ?? "") : (url ?? "");

  ///本地
  String get imageLocalPath =>
      isVideo ? (thumbUrl ?? "") : (localFilePath ?? "");
}
