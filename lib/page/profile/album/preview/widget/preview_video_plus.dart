import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/custom_message_widget/count_down_widget.dart';
import 'package:video_player/video_player.dart';

class PreviewVideoPlus extends StatefulWidget {
  final String url;
  final String? thumbUrl;
  final bool? isPrivate;
  final Function? onFinished;
  const PreviewVideoPlus({
    super.key,
    required this.url,
    this.isPrivate,
    this.thumbUrl,
    this.onFinished,
  });

  @override
  State<PreviewVideoPlus> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideoPlus>
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
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox.expand(),

          Center(
            child: _controller.value.isInitialized
                ? GestureDetector(
                    onTap: () {
                      if (isPlaying) {
                        setState(() {
                          _controller.pause();
                          isPlaying = false;
                        });
                      } else {
                        setState(() {
                          _controller.play();
                          isPlaying = true;
                        });
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),

                        if (!isPlaying)
                          Center(
                            child: Image.asset(
                              Assets.imgNotificationPlay,
                              width: 50,
                              height: 50,
                            ),
                          ),
                      ],
                    ),
                  )
                : buildLoading(),
          ),

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
                            },
                            child: Image.asset(
                              Assets.imgSmallPlay,
                              width: 24,
                              height: 24,
                            ),
                          ),
                          VerticalDivider(
                            width: 16.w,
                            color: Colors.transparent,
                          ),
                          Text(
                            _formatDuration(videoPlayerValue.position),
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
                                    bufferedColor: Colors.white.withValues(
                                      alpha: 0.5,
                                    ),
                                    backgroundColor: Colors.white.withValues(
                                      alpha: 0.3,
                                    ),
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
                            _formatDuration(
                              videoPlayerValue.duration ?? Duration.zero,
                            ),
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

                if (widget.isPrivate == true)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    width: double.maxFinite,
                    padding: EdgeInsetsDirectional.only(
                      top: 12.h,
                      bottom: 12.h,
                    ),
                    alignment: Alignment.center,
                    child: CountDownWidget(
                      totalDuration: 60,
                      alpha: 0,
                      onFinished: () {
                        widget.onFinished?.call();
                      },
                    ),
                  ),
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).padding.bottom,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  String _formatDuration(Duration position) {
    final ms = position.inMilliseconds;

    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    final minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
        ? '00'
        : '0$hours';

    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
        ? '00'
        : '0$minutes';

    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
        ? '00'
        : '0$seconds';

    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';

    return formattedTime;
  }
}
