import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newbug/generated/assets.dart';

class BuildNotificationImage extends StatelessWidget {
  final String url;
  final bool? isPrivate;
  final bool? isVideo;
  const BuildNotificationImage({
    super.key,
    required this.url,
    this.isPrivate,
    this.isVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(url),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isPrivate ?? false)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
              ),
            ),

          if (isVideo ?? false)
            Image.asset(Assets.imgNotificationPlay, width: 30, height: 30),
        ],
      ),
    );
  }
}
