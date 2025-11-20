import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_thumbnail/flutter_video_thumbnail.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/generated/assets.dart';
import 'package:video_player/video_player.dart';

class PrivateAlbumVideoPlus extends StatefulWidget {
  final String url;
  final String? thumbUrl;
  final Widget? child;

  const PrivateAlbumVideoPlus({
    super.key,
    required this.url,
    this.thumbUrl,
    this.child,
  });

  @override
  State<PrivateAlbumVideoPlus> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PrivateAlbumVideoPlus>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    initVideoCtrl();
  }

  @override
  void dispose() {
    _controller.pause();
    isPlaying = false;
    _controller.dispose();
    super.dispose();
  }

  initVideoCtrl() {
    _controller =
        VideoPlayerController.networkUrl(
            Uri.parse(widget.url),
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          )
          ..initialize().then((_) {
            setState(() {
              _controller.play();
              isPlaying = true;
            });
          });
    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: [
                Material(
                  elevation: 0,
                  color: Colors.black,
                  child: SizedBox.expand(
                    child: (!_controller.value.isInitialized)
                        ? Stack(
                            fit: StackFit.expand,
                            alignment: AlignmentDirectional.center,
                            children: [
                              if (widget.thumbUrl != null &&
                                  File(widget.thumbUrl ?? "").existsSync())
                                buildFileImage(widget.thumbUrl ?? "")
                              else
                                buildPreviewVideo(widget.url),
                              Center(child: buildLoading()),
                            ],
                          )
                        : FittedBox(
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                            child: SizedBox(
                              width: _controller.value.size.width,
                              height: _controller.value.size.height,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                  ),
                ),
                if (_controller.value.isInitialized)
                  PositionedDirectional(
                    bottom: 0,
                    start: 0,
                    end: 0,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w,
                          ),
                          width: double.maxFinite,
                          color: Colors.black.withValues(alpha: 0.5),
                          child: ValueListenableBuilder<VideoPlayerValue>(
                            valueListenable: _controller,
                            builder: (context, videoPlayerValue, child) {
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (_controller.value.isInitialized) {
                                        if (videoPlayerValue.isPlaying) {
                                          _controller.pause();
                                          setState(() {
                                            isPlaying = false;
                                          });
                                        } else {
                                          _controller.play();
                                          setState(() {
                                            isPlaying = true;
                                          });
                                        }
                                      } else {
                                        debugPrint(
                                          "isInitialized:${_controller.value.isInitialized} ",
                                        );
                                      }
                                    },
                                    child: Image.asset(
                                      isPlaying
                                          ? Assets.imgSmallPause
                                          : Assets.imgSmallPlay,
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 16.w,
                                    color: Colors.transparent,
                                  ),
                                  Text(
                                    formatTime(videoPlayerValue.position),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 7.w,
                                    color: Colors.transparent,
                                  ),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        VideoProgressIndicator(
                                          _controller,
                                          colors: VideoProgressColors(
                                            playedColor: Colors.white,
                                            bufferedColor: Colors.white
                                                .withValues(alpha: 0.5),
                                            backgroundColor: Colors.white
                                                .withValues(alpha: 0.3),
                                          ),
                                          allowScrubbing: true,
                                        ),
                                        LayoutBuilder(
                                          builder: (context, constraints) {
                                            double w = constraints.maxWidth;
                                            double dotPosition =
                                                w *
                                                videoPlayerValue
                                                    .position
                                                    .inMilliseconds /
                                                videoPlayerValue
                                                    .duration
                                                    .inMilliseconds;
                                            return Transform.translate(
                                              offset: Offset(dotPosition, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                width: 14.r,
                                                height: 14.r,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 7.w,
                                    color: Colors.transparent,
                                  ),
                                  Text(
                                    formatTime(videoPlayerValue.duration),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          widget.child ?? SizedBox.shrink(),
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).padding.bottom,
            color: Colors.black.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }

  Widget buildFileImage(String path) {
    return Image.file(File(path), fit: BoxFit.cover);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        _controller.play();
        setState(() {
          isPlaying = true;
        });
        break;
      case AppLifecycleState.paused:
        if (isPlaying) {
          _controller.pause();
          setState(() {
            isPlaying = false;
          });
        }
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  Widget buildLoading() => CircularProgressIndicator(
    //: (controller.progress / 100).toDouble(),
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  );

  String formatTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final timeParts = [
      if (hours > 0) hours.toString().padLeft(2, '0'),
      minutes.toString().padLeft(2, '0'),
      seconds.toString().padLeft(2, '0'),
    ];

    return timeParts.join(':');
  }

  Widget buildPreviewVideo(String url) {
    String localFilePath = AppStores.getThumb(key: url);
    if (File(localFilePath).existsSync()) {
      return Image.file(File(localFilePath), fit: BoxFit.cover);
    } else {
      return FutureBuilder(
        future: getThumbnail(url),
        builder: (_, AsyncSnapshot<File?> snapshot) {
          String localFilePath = AppStores.getThumb(key: url);
          if (File(localFilePath).existsSync()) {
            return Image.file(File(localFilePath), fit: BoxFit.cover);
          }
          return (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData)
              ? Image.file(File(localFilePath), fit: BoxFit.cover)
              : SizedBox.shrink();
        },
      );
    }
  }

  Future<File?> getThumbnail(String videoPath) async {
    final cacheManager = DefaultCacheManager();
    FileInfo? fileInfo = await cacheManager.getFileFromCache(videoPath);
    if (fileInfo == null) {
      Uint8List? thumbnailData = await FlutterVideoThumbnail.getThumbnail(
        videoPath,
      );
      if (thumbnailData != null) {
        File thumbnailFile = await cacheManager.putFile(
          videoPath,
          thumbnailData,
        );
        AppStores.setThumb(key: videoPath, value: thumbnailFile.path);
        return thumbnailFile;
      } else {
        return null;
      }
    } else {
      AppStores.setThumb(key: videoPath, value: fileInfo.file.path);
      return fileInfo.file;
    }
  }
}
