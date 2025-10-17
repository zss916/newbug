import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class ChatPickImage extends StatelessWidget {
  final Function() onPublicAlbum;
  final Function() onPrivateAlbum;
  const ChatPickImage({
    super.key,
    required this.onPublicAlbum,
    required this.onPrivateAlbum,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPopup(
      contentRadius: 12.r,
      contentPadding: EdgeInsets.symmetric(vertical: 6.h),
      position: PopupPosition.top,
      backgroundColor: Colors.white,
      showArrow: false,
      arrowColor: Colors.white,
      barrierColor: Colors.transparent,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                // Navigator.maybePop(context);
                Get.back();
                onPublicAlbum.call();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8.w),
                      child: Image.asset(
                        Assets.imgPublicAlbum,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Text(
                      T.publicAlbum.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF262626),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                //Navigator.maybePop(context);
                Get.back();
                onPrivateAlbum.call();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8.w),
                      child: Image.asset(
                        Assets.imgPrivateAlbum,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Text(
                      T.privateAlbum.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF262626),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      child: Image.asset(Assets.imgChatAlbum, width: 40, height: 40),
    );
  }
}
