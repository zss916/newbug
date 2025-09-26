import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/home/widget/video/switch_mute.dart';

class BetterNetVideo extends StatefulWidget {
  final String video;
  final double ratio;
  final Function(bool)? onVideoStatus;

  const BetterNetVideo({
    super.key,
    required this.video,
    required this.ratio,
    this.onVideoStatus,
  });

  @override
  State<BetterNetVideo> createState() => _BetterNetVideoState();
}

class _BetterNetVideoState extends State<BetterNetVideo>
    with WidgetsBindingObserver {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  late VoidCallback listener;
  late bool isPlay = true;
  late bool pause = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initVideoCtrl();
    listener = () {
      if (_betterPlayerController.videoPlayerController != null) {
        final value = _betterPlayerController.videoPlayerController?.value;
        double playedPartPercent =
            (value?.position.inMilliseconds ?? 0) /
            (value?.duration?.inMilliseconds ?? 0);
        if (playedPartPercent.isNaN) {
          playedPartPercent = 0;
        }
        setState(() {
          isPlay = _betterPlayerController.isPlaying() ?? false;
        });
      }
    };
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _betterPlayerController.videoPlayerController?.removeListener(listener);
    _betterPlayerController.pause();
    _betterPlayerController.dispose();
    super.dispose();
  }

  initVideoCtrl() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
          looping: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableMute: false,
            enableAudioTracks: false,
            enableFullscreen: false,
            enableOverflowMenu: false,
            enableSubtitles: false,
            enableQualities: false,
            enablePip: false,
            enablePlaybackSpeed: false,
            enablePlayPause: false,
            enableRetry: false,
            enableSkips: false,
            enableProgressBar: false,
            enableProgressBarDrag: false,
            enableProgressText: false,
            playerTheme: BetterPlayerTheme.custom,
            controlBarColor: Colors.transparent,
            showControlsOnInitialize: false,
          ),
          aspectRatio: 1 / 1,
          fit: BoxFit.cover,
        );
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
        key: widget.video,
      ),
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setControlsAlwaysVisible(true);
    _betterPlayerController.setControlsEnabled(true);
    _betterPlayerController.setOverriddenAspectRatio(widget.ratio);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource).then((d) {
      if (!mounted) return;
      _betterPlayerController.videoPlayerController?.addListener(listener);
      setState(() {
        widget.onVideoStatus?.call(false);
        _betterPlayerController.pause();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: _betterPlayerController.isVideoInitialized() == true
            ? GestureDetector(
                onTap: () {
                  if (_betterPlayerController.isPlaying() == true) {
                    _betterPlayerController.pause();
                    widget.onVideoStatus?.call(false);
                  } else {
                    _betterPlayerController.play();
                    widget.onVideoStatus?.call(true);
                  }
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipRRect(
                      child: BetterPlayer(controller: _betterPlayerController),
                    ),
                    if (!isPlay)
                      Center(
                        child: Image.asset(
                          Assets.imgPlay,
                          width: 54,
                          height: 54,
                        ),
                      ),

                    PositionedDirectional(
                      start: 14.w,
                      bottom: 16.h,
                      child: SwitchMute(
                        onSwitch: (isMute) {
                          _betterPlayerController.setVolume(isMute ? 0 : 1);
                        },
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        _betterPlayerController.play();
        break;
      case AppLifecycleState.paused:
        if (isPlay) {
          _betterPlayerController.pause();
        }
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }
}
