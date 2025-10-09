import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class BuildPrivateAlbum extends StatelessWidget {
  final Function? onTap;
  const BuildPrivateAlbum({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(
            start: 14.w,
            end: 14.w,
            top: 26.h,
          ),
          width: double.maxFinite,
          child: Text(
            T.privateAlbum.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(
            start: 14.w,
            end: 14.w,
            bottom: 60.h,
            top: 10.h,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              onTap?.call();
            },
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black.withValues(alpha: 0.10),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      T.privateAlbumTitle.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 10.w),
                    child: Image.asset(
                      Assets.imgArrowEnd,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
