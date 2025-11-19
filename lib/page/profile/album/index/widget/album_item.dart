import 'dart:async';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/mixin/upload_file_mixin.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/upload/service/image_service.dart';
import 'package:newbug/core/upload/service/video_service.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/profile/album/index/widget/private_video_thumbnail_widget.dart';

class AlbumItem extends StatefulWidget {
  final MediaListItem? item;
  final Function(MediaListItem item) onSelected;
  final bool isCanSelect;
  const AlbumItem({
    super.key,
    this.item,
    required this.onSelected,
    required this.isCanSelect,
  });

  @override
  State<AlbumItem> createState() => _AlbumItemState();
}

class _AlbumItemState extends State<AlbumItem>
    with AutomaticKeepAliveClientMixin, UploadFileMixin {
  bool isChecked = false;

  /// 防止触发多次上传动作
  var _isLoading = false;

  @override
  bool get wantKeepAlive => true;

  /// 请求成功或失败
  final _successVN = ValueNotifier(true);

  /// 上传进度
  final _percentVN = ValueNotifier(0.0);
  StreamSubscription<SelectPrivateAlbumEvent>? subs2;

  @override
  void initState() {
    super.initState();
    onRefresh();
    isChecked = (widget.item?.isChecked == true);
    subs2 = EventService.to.listen<SelectPrivateAlbumEvent>((event) {
      if (widget.item?.id == event.media?.id) {
        setState(() {
          widget.item?.isChecked = event.media?.isChecked;
          isChecked = event.media?.isChecked ?? false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subs2?.cancel();
  }

  @override
  void didUpdateWidget(covariant AlbumItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item?.id == oldWidget.item?.id) {
      return;
    }
  }

  ///刷新
  void onRefresh() {
    // debugPrint("onRefresh start ; ${widget.item?.toJson()}");
    final entityFilePath = widget.item?.localFilePath;

    if (entityFilePath == null) {
      return;
    }
    // debugPrint("onRefresh _isLoading:$_isLoading");
    if (_isLoading) {
      // debugPrint("_isLoading: $_isLoading ${widget.item}");
      return;
    }
    _isLoading = true;
    _successVN.value = true;
    // debugPrint("onRefresh start compress");
    Future.value(File(entityFilePath))
        .then((file) {
          final fileNew = !(widget.item?.isVideo ?? false)
              ? ImageService().compressAndGetFile(file)
              : VideoService.compressVideo(file);
          return fileNew;
        })
        .then((file) {
          //  debugPrint("onRefresh compress :$file");
          widget.item?.localFile = file;
          setState(() {});

          final path = widget.item?.localFile?.path;
          if (path == null) {
            throw "文件路径为空";
          }
          return toUpload(file: File(path))
              .then((value) {
                final url = value;
                if (url == null || url.isEmpty) {
                  _successVN.value = false;
                  throw "上传失败 ${widget.item?.localFile?.path}";
                }
                _successVN.value = true;
                widget.item?.url = url;
                addPrivate(
                  type: widget.item?.type ?? 0,
                  url: url,
                  duration: widget.item?.duration,
                ).then((value) {
                  // debugPrint("onRefresh addPrivate :$value");
                  _percentVN.value = 1;
                });
                // debugPrint("url===>>> $url");
              })
              .catchError((err) {
                debugPrint("onRefresh err :$err");
                debugPrint("err: $err");
                widget.item?.url = "";
                _successVN.value = false;
              })
              .whenComplete(() {
                debugPrint("onRefresh Complete ");
                _isLoading = false;
                //widget.urlBlock?.call(widget.model.url ?? "");
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildItem(item: widget.item!);
  }

  Widget buildItem({required MediaListItem item}) {
    // debugPrint("item ==> ${item.toJson()}");
    return switch (item.type) {
      ///图片
      _ when item.type == 0 => Stack(
        children: [
          ///网络
          if (widget.item?.url?.startsWith("http") == true)
            Container(
              decoration: BoxDecoration(
                color: Color(0x1A000000),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExtendedNetworkImageProvider(
                    widget.item?.imageUrl ?? "",
                  ),
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (widget.item?.isVideo ?? false)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: ShapeDecoration(
                                  color: Colors.black.withValues(alpha: 0.50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsetsDirectional.only(
                                        end: 3.w,
                                      ),
                                      child: Image.asset(
                                        Assets.imgIcAlbumVideo,
                                        width: 12,
                                        height: 12,
                                      ),
                                    ),
                                    Text(
                                      widget.item?.showVideoDuration ?? "00:00",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Spacer(),
                            if (widget.isCanSelect)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                    widget.item?.isChecked = isChecked;
                                    widget.onSelected(widget.item!);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsetsDirectional.only(
                                    start: 5.w,
                                  ),
                                  child: Image.asset(
                                    isChecked
                                        ? Assets.imgCheckedIcon
                                        : Assets.imgUncheckIcon,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.item?.url?.startsWith("http") != true)
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: buildUploading(),
                    ),
                ],
              ),
            ),

          ///本地
          if (widget.item?.url == null &&
              (widget.item?.localFilePath != null) &&
              File(widget.item?.localFilePath ?? "").existsSync())
            Container(
              decoration: BoxDecoration(
                color: Color(0x1A000000),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExtendedFileImageProvider(
                    File(widget.item?.localFilePath ?? ""),
                  ),
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (widget.item?.isVideo ?? false)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: ShapeDecoration(
                                  color: Colors.black.withValues(alpha: 0.50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsetsDirectional.only(
                                        end: 3.w,
                                      ),
                                      child: Image.asset(
                                        Assets.imgIcAlbumVideo,
                                        width: 12,
                                        height: 12,
                                      ),
                                    ),
                                    Text(
                                      widget.item?.showVideoDuration ?? "00:00",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Spacer(),
                            if (widget.isCanSelect)
                              Container(
                                margin: EdgeInsetsDirectional.only(start: 5.w),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isChecked = !isChecked;
                                      widget.item?.isChecked = isChecked;
                                      widget.onSelected(widget.item!);
                                    });
                                  },
                                  child: Image.asset(
                                    isChecked
                                        ? Assets.imgCheckedIcon
                                        : Assets.imgUncheckIcon,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.item?.url?.startsWith("http") != true)
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: buildUploading(),
                    ),
                ],
              ),
            ),
        ],
      ),

      ///视频
      _ when item.type == 1 => Stack(
        children: [
          ///本地
          if ((widget.item?.isVideo ?? false) &&
              widget.item?.thumbUrl != null &&
              File(widget.item?.thumbUrl ?? "").existsSync())
            Container(
              decoration: BoxDecoration(
                color: Color(0x1A000000),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExtendedFileImageProvider(
                    File(widget.item?.thumbUrl ?? ""),
                  ),
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (widget.item?.isVideo ?? false)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: ShapeDecoration(
                                  color: Colors.black.withValues(alpha: 0.50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsetsDirectional.only(
                                        end: 3.w,
                                      ),
                                      child: Image.asset(
                                        Assets.imgIcAlbumVideo,
                                        width: 12,
                                        height: 12,
                                      ),
                                    ),
                                    Text(
                                      widget.item?.showVideoDuration ?? "00:00",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Spacer(),
                            if (widget.isCanSelect)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                    widget.item?.isChecked = isChecked;
                                    widget.onSelected(widget.item!);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsetsDirectional.only(
                                    start: 5.w,
                                  ),
                                  child: Image.asset(
                                    isChecked
                                        ? Assets.imgCheckedIcon
                                        : Assets.imgUncheckIcon,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.item?.url?.startsWith("http") != true)
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: buildUploading(),
                    ),
                ],
              ),
            ),

          /// 网络
          if (widget.item?.url?.startsWith("http") == true)
            PrivateVideoThumbnailWidget(
              videoPath: item.url ?? "",
              item: item,
              w: double.maxFinite,
              h: double.maxFinite,
              borderRadius: BorderRadius.zero,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.black.withValues(alpha: 0.50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsetsDirectional.only(
                                      end: 3.w,
                                    ),
                                    child: Image.asset(
                                      Assets.imgIcAlbumVideo,
                                      width: 12,
                                      height: 12,
                                    ),
                                  ),
                                  Text(
                                    item.showVideoDuration ?? "00:00",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            if (widget.isCanSelect)
                              Container(
                                margin: EdgeInsetsDirectional.only(start: 5.w),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isChecked = !isChecked;
                                      widget.item?.isChecked = isChecked;
                                      widget.onSelected(widget.item!);
                                    });
                                  },
                                  child: Image.asset(
                                    isChecked
                                        ? Assets.imgCheckedIcon
                                        : Assets.imgUncheckIcon,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      _ => SizedBox.shrink(),
    };
  }

  Widget buildUploading() {
    return AnimatedBuilder(
      animation: Listenable.merge([_successVN, _percentVN]),
      builder: (context, child) {
        if (_successVN.value == false) {
          return buildUploadFail();
        }

        final value = _percentVN.value;
        if (value >= 1) {
          return const SizedBox.shrink();
        }

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.black38),
          child: Center(
            child: CircularProgressIndicator(color: Color(0xFFFF0092)),
          ),
        );
      },
    );
  }

  Widget buildUploadFail() {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            _percentVN.value = 0;
            debugPrint("onTap");
            onRefresh();
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.black38),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh, color: Colors.red),
                Text(
                  "Click to retry",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        // Positioned(top: 0, right: 0, child: buildDelete()),
      ],
    );
  }
}
