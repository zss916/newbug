import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus.dart';
import 'package:newbug/core/widget/generated/assets.dart';

class VideoThumbnailWidget extends StatelessWidget {
  final String videoPath;
  const VideoThumbnailWidget({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterVideoThumbnailPlus.thumbnailFile(
        video: videoPath,
        imageFormat: ImageFormat.jpeg,
        maxHeight: 150,
        quality: 100,
      ),
      builder: (_, AsyncSnapshot<String?> snapshot) {
        return (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData)
            ? Container(
                width: 108,
                height: 143,
                decoration: ShapeDecoration(
                  color: Colors.grey.shade200,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(snapshot.data ?? "")),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
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
              )
            : Center(
                child: CircularProgressIndicator(color: Color(0xFFFF0092)),
              );
      },
    );
  }
}
