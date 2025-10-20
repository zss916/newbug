import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';
import 'package:video_player/video_player.dart';

class PreviewMultipleVideo extends StatefulWidget {
  final String url;
  final String? thumbUrl;
  final Widget? child;

  const PreviewMultipleVideo({
    super.key,
    required this.url,
    this.thumbUrl,
    this.child,
  });

  @override
  State<PreviewMultipleVideo> createState() => _PreviewMultipleVideoState();
}

class _PreviewMultipleVideoState extends State<PreviewMultipleVideo>
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
          Material(
            elevation: 0,
            color: Colors.black,
            child: SizedBox.expand(
              child: (!_controller.value.isInitialized)
                  ? Center(child: buildLoading())
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
                            formatTime(
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
                widget.child ?? SizedBox.shrink(),
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
}
