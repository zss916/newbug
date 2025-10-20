import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:newbug/generated/assets.dart';

class PreviewVideo extends StatefulWidget {
  final String url;
  final String? thumbUrl;
  const PreviewVideo({super.key, required this.url, this.thumbUrl});

  @override
  State<PreviewVideo> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideo>
    with WidgetsBindingObserver {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  late VoidCallback listener;
  late bool isPlay = true;
  late bool pause = false;

  @override
  void initState() {
    super.initState();
    initVideoCtrl();
    listener = () {
      if (_betterPlayerController.videoPlayerController != null) {
        //  _betterPlayerController.betterPlayerControlsConfigurationFullScreen;

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
    _betterPlayerController.videoPlayerController?.removeListener(listener);
    //.exitFullScreen();
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
      widget.url,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
        key: widget.url,
      ),
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setControlsAlwaysVisible(true);
    _betterPlayerController.setControlsEnabled(true);

    _betterPlayerController.setupDataSource(_betterPlayerDataSource).then((d) {
      if (!mounted) return;
      _betterPlayerController.videoPlayerController?.addListener(listener);
      setState(() {
        _betterPlayerController.pause();
      });
    });
    //_betterPlayerController.enterFullScreen();
    _betterPlayerController.setOverriddenFit(BoxFit.cover);
    _betterPlayerController.setOverriddenAspectRatio(
      _betterPlayerController.getAspectRatio() ?? 1,
    );
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
                  } else {
                    _betterPlayerController.play();
                  }
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox.expand(
                      child: BetterPlayer(controller: _betterPlayerController),
                    ),

                    if (!isPlay)
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
            : Center(
                child: CircularProgressIndicator(
                  //: (controller.progress / 100).toDouble(),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
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
