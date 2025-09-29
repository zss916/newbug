import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeBlurWidget extends StatelessWidget {
  final bool isBlur;
  final int index;
  final Widget child;
  const LikeBlurWidget({
    super.key,
    required this.isBlur,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: index == 0 ? Radius.circular(22.r) : Radius.circular(8.r),
        topRight: index == 0 ? Radius.circular(22.r) : Radius.circular(8.r),
        bottomLeft: index == 0 ? Radius.circular(22.r) : Radius.circular(8.r),
        bottomRight: index == 0 ? Radius.circular(59.r) : Radius.circular(8.r),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: isBlur ? 5 : 0,
          sigmaY: isBlur ? 5 : 0,
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsetsDirectional.all(index == 0 ? 10 : 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: isBlur ? 0.55 : 0),
          ),
          width: double.maxFinite,
          height: double.maxFinite,
          child: child,
        ),
      ),
    );
  }
}
