import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';

class HomeBottomMenu extends StatelessWidget {
  final Function onNext;
  final Function onLike;
  final Function onChat;

  const HomeBottomMenu({
    super.key,
    required this.onChat,
    required this.onNext,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        start: 14.w,
        end: 14.w,
        top: 20.h,
        bottom: 100.h,
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () {
              onNext.call();
            },
            child: Image.asset(Assets.imgHomeClose, width: 48, height: 48),
          ),
          VerticalDivider(width: 9.w, color: Colors.transparent),
          InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () {
              onLike.call();
            },
            child: Image.asset(Assets.imgFabLike, width: 48, height: 48),
          ),
          Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              onChat.call();
            },
            child: Container(
              height: 50,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Color(0xFFFF0092),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Image.asset(Assets.imgMsgIc, width: 26, height: 26),
                  Text(
                    T.chatNow.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1.29,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
