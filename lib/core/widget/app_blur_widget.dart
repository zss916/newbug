import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBlurWidget extends StatelessWidget {
  final Widget? child;
  final bool isBlur;
  final double? sigma;
  final Widget? foreground;
  final BorderRadiusGeometry? borderRadius;
  final StackFit? stackFit;
  const AppBlurWidget({
    super.key,
    required this.isBlur,
    this.foreground,
    this.child,
    this.sigma,
    this.borderRadius,
    this.stackFit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: stackFit ?? StackFit.loose,
      alignment: AlignmentDirectional.center,
      children: [
        ?child,
        if (isBlur)
          Positioned.fill(
            child: ClipRRect(
              borderRadius:
                  borderRadius ??
                  BorderRadius.only(
                    topLeft: Radius.circular(48.r),
                    topRight: Radius.circular(48.r),
                    bottomLeft: Radius.circular(48.r),
                    bottomRight: Radius.circular(146.r),
                  ),
              child: RepaintBoundary(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: sigma ?? 2.8,
                    sigmaY: sigma ?? 2.8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),
        if (isBlur) ?foreground,
      ],
    );
  }
}
