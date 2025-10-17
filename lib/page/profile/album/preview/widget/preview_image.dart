import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  final String url;
  const PreviewImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      fit: BoxFit.cover,
      enableSlideOutPage: true,
      mode: ExtendedImageMode.gesture,
      initGestureConfigHandler: (ExtendedImageState state) {
        double? initialScale = 1.0;

        if (state.extendedImageInfo != null) {
          initialScale = setScale(
            size: MediaQuery.of(context).size,
            initialScale: initialScale,
            imageSize: Size(
              state.extendedImageInfo!.image.width.toDouble(),
              state.extendedImageInfo!.image.height.toDouble(),
            ),
          );
        }
        return GestureConfig(
          inPageView: true,
          initialScale: initialScale,
          maxScale: max(initialScale, 5.0),
          animationMaxScale: max(initialScale, 5.0),
          initialAlignment: InitialAlignment.center,
          cacheGesture: false,
        );
      },
    );
  }
}

double setScale({
  required Size imageSize,
  required Size size,
  double? initialScale,
}) {
  final double n1 = imageSize.height / imageSize.width;
  final double n2 = size.height / size.width;
  if (n1 > n2) {
    final FittedSizes fittedSizes = applyBoxFit(
      BoxFit.contain,
      imageSize,
      size,
    );
    final Size destinationSize = fittedSizes.destination;
    return size.width / destinationSize.width;
  } else if (n1 / n2 < 1 / 4) {
    final FittedSizes fittedSizes = applyBoxFit(
      BoxFit.contain,
      imageSize,
      size,
    );
    final Size destinationSize = fittedSizes.destination;
    return size.height / destinationSize.height;
  }
  return initialScale ?? 0;
}
