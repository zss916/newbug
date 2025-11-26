import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  const HomeCard({super.key, required this.child, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          margin ??
          EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 18.h),
      width: double.maxFinite,
      child: AspectRatio(
        aspectRatio: 362 / 483,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.black),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
              bottomLeft: Radius.circular(50.r),
              bottomRight: Radius.circular(148.r),
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(48.r),
                  topRight: Radius.circular(48.r),
                  bottomLeft: Radius.circular(48.r),
                  bottomRight: Radius.circular(146.r),
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
