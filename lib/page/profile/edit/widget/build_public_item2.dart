import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class BuildPublicItem2 extends StatelessWidget {
  final String title;
  final String? value;
  final Function? onTap;
  const BuildPublicItem2({
    super.key,
    required this.title,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w),
      width: double.maxFinite,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          onTap?.call();
        },
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 10,
            bottom: 20,
          ),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.black.withValues(alpha: 0.10),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Image.asset(Assets.imgArrowEnd, width: 20, height: 20),
                ],
              ),
              if ((value ?? "").isNotEmpty)
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    value ?? "",
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.70),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
