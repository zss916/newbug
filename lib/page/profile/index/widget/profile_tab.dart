import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/profile/sheet/pay/pay_sheet.dart';

class ProfileTab extends StatelessWidget {
  final String videosCount;
  final String photosCount;
  final String chatsCount;
  const ProfileTab({
    super.key,
    required this.chatsCount,
    required this.photosCount,
    required this.videosCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 12.h),
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                showPaySheet(index: 0);
              },
              child: AspectRatio(
                aspectRatio: 114 / 142,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 10.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      stops: [0, 0.5],
                      colors: [Color(0xFFFFE8F5), Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Image.asset(
                          Assets.imgPrivateVideos,
                          width: 36.r,
                          height: 36.r,
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(top: 10.h),
                        width: double.maxFinite,
                        child: Text(
                          T.privateVideos.tr,
                          maxLines: 1,
                          style: TextStyle(
                            color: const Color(0xFF262626),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '35',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: const Color(0xFFFF0092),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' ${T.left.tr}',
                                style: TextStyle(
                                  color: const Color(0xFF8C8C8C),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            T.getNow.tr,
                            style: TextStyle(
                              color: const Color(0xFF8C8C8C),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 1.18,
                              letterSpacing: -0.30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 4.w),
                            child: Image.asset(Assets.imgIcNext, width: 5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          VerticalDivider(width: 10.w, color: Colors.transparent),

          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                showPaySheet(index: 1);
              },
              child: AspectRatio(
                aspectRatio: 114 / 142,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 10.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      stops: [0, 0.5],
                      colors: [Color(0xFFEDE8FF), Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Image.asset(
                          Assets.imgPrivatePhotos,
                          width: 36.r,
                          height: 36.r,
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(top: 10.h),
                        width: double.maxFinite,
                        child: Text(
                          T.privatePhotos.tr,
                          maxLines: 1,
                          style: TextStyle(
                            color: const Color(0xFF262626),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '35',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: const Color(0xFF7D60FF),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' ${T.left.tr}',
                                style: TextStyle(
                                  color: const Color(0xFF8C8C8C),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            T.getNow.tr,
                            style: TextStyle(
                              color: const Color(0xFF8C8C8C),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 1.18,
                              letterSpacing: -0.30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 4.w),
                            child: Image.asset(Assets.imgIcNext, width: 5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          VerticalDivider(width: 10.w, color: Colors.transparent),

          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                showPaySheet(index: 2);
              },
              child: AspectRatio(
                aspectRatio: 114 / 142,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 10.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      stops: [0, 0.5],
                      colors: [Color(0xFFFFF4E1), Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Image.asset(
                          Assets.imgFlashChat,
                          width: 36.r,
                          height: 36.r,
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(top: 10.h),
                        width: double.maxFinite,
                        child: Text(
                          T.flashChat.tr,
                          maxLines: 1,
                          style: TextStyle(
                            color: const Color(0xFF262626),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '35',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: const Color(0xFFFFB12B),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' ${T.left.tr}',
                                style: TextStyle(
                                  color: const Color(0xFF8C8C8C),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            T.getNow.tr,
                            style: TextStyle(
                              color: const Color(0xFF8C8C8C),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 1.18,
                              letterSpacing: -0.30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 4.w),
                            child: Image.asset(Assets.imgIcNext, width: 5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
