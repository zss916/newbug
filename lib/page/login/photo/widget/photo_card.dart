import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/generated/assets.dart';

class PhotoCard extends StatelessWidget {
  final int index;
  final Function(int)? onAdd;
  final Function(int)? onEdit;
  final MediaListItem? item;

  const PhotoCard({
    super.key,
    this.item,
    required this.index,
    this.onAdd,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (item != null)
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              onEdit?.call(index);
            },
            child: buildItem(item: item!),
          )
        else
          buildAddItem(onAdd),
      ],
    );
  }

  Widget buildItem({required MediaListItem item}) {
    return switch (item.type) {
      ///图片
      _ when item.type == 0 => Stack(
        children: [
          Container(
            width: 108,
            height: 143,
            decoration: (item.url ?? "").isNotEmpty
                ? ShapeDecoration(
                    color: Colors.grey.shade200,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(item.url ?? ""),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )
                : ShapeDecoration(
                    color: Colors.grey.shade200,
                    image: item.imageLocalPath.isEmpty
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(item.imageLocalPath)),
                          ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                if (item.isVideo)
                  PositionedDirectional(
                    top: 6,
                    start: 6,
                    child: Image.asset(
                      Assets.imgVideoIcon,
                      width: 30,
                      height: 20,
                    ),
                  ),
                PositionedDirectional(
                  bottom: 6,
                  end: 6,
                  child: Image.asset(Assets.imgEditIcon, width: 24, height: 24),
                ),
              ],
            ),
          ),
        ],
      ),

      ///视频
      _ when item.type == 1 => Stack(
        children: [
          ///本地 和 网络连接
          //VideoThumbnailWidget(videoPath: item.url ?? ""),
          if ((item.thumbUrl ?? "").isNotEmpty)
            Container(
              width: 108,
              height: 143,
              decoration: ShapeDecoration(
                color: Colors.grey.shade200,
                image: item.imageLocalPath.isEmpty
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(item.imageLocalPath)),
                      ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  if (item.isVideo)
                    PositionedDirectional(
                      top: 6,
                      start: 6,
                      child: Image.asset(
                        Assets.imgVideoIcon,
                        width: 30,
                        height: 20,
                      ),
                    ),
                  PositionedDirectional(
                    bottom: 6,
                    end: 6,
                    child: Image.asset(
                      Assets.imgEditIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      _ => buildAddItem(onAdd),
    };
  }

  ///添加
  Widget buildAddItem(Function(int)? onAdd) => InkWell(
    borderRadius: BorderRadius.circular(8),
    onTap: () {
      onAdd?.call(index);
    },
    child: Image.asset(Assets.imgPhotoAdd, width: 108, height: 143),
  );
}
