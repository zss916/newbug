import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class BuildDesiresItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isSelected;
  final Function? onTap;
  const BuildDesiresItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // borderRadius: BorderRadius.circular(12),
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: double.maxFinite,
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(14.r),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected
                  ? Color(0xFFFF0092)
                  : Colors.black.withValues(alpha: 0.50),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5.h,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 5.w),
                    child: Image.asset(
                      isSelected
                          ? Assets.imgCheckedIcon
                          : Assets.imgUncheckIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Text(
                subTitle,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.60),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
