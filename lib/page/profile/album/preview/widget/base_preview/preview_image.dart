import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

enum ImageType { network, file, memory }

class PreviewImage extends StatelessWidget {
  final String url;
  final ImageType type;

  const PreviewImage({super.key, required this.url, required this.type});

  @override
  Widget build(BuildContext context) => buildImage(type, context, url);

  Widget buildImage(ImageType type, BuildContext context, String url) {
    return switch (type) {
      _ when type == ImageType.network => buildNetWorkImage(context, url),
      _ when (type == ImageType.file) && File(url).existsSync() =>
        buildFileImage(context, url),
      _ when type == ImageType.memory => buildMemoryImage(context, url),
      _ => SizedBox.shrink(),
    };
  }

  Widget buildNetWorkImage(BuildContext context, String url) =>
      ExtendedImage.network(
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

  Widget buildFileImage(BuildContext context, String url) {
    return ExtendedImage.file(
      File(url),
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

  Widget buildMemoryImage(BuildContext context, String url) =>
      ExtendedImage.memory(
        base64Decode(url),
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
