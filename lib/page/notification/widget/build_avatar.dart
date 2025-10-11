import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newbug/generated/assets.dart';

class BuildAvatar extends StatelessWidget {
  final String url;
  const BuildAvatar({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 56,
          height: 56,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(url),
            ),
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        PositionedDirectional(
          top: 0,
          end: 0,
          child: Image.asset(Assets.imgDotOnline, width: 14, height: 14),
        ),
      ],
    );
  }
}
