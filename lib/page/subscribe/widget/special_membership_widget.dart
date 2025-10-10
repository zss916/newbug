import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/subscribe/widget/build_subscribe_avatar.dart';
import 'package:newbug/page/subscribe/widget/privilege_item_widget.dart';

class SpecialMembershipWidget extends StatelessWidget {
  const SpecialMembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFFFFEE30)),
          margin: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
          width: double.maxFinite,
          height: 240.h,
          constraints: BoxConstraints(minHeight: 240.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              PositionedDirectional(
                start: 0,
                top: 0,
                child: Image.asset(Assets.decorationKing, width: 280),
              ),

              PositionedDirectional(
                bottom: 0,
                start: 0,
                end: 0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        BuildSubscribeAvatar(),
                        VerticalDivider(width: 10.w, color: Colors.transparent),
                        BuildSubscribeAvatar(),
                        VerticalDivider(width: 10.w, color: Colors.transparent),
                        BuildSubscribeAvatar(),
                        VerticalDivider(width: 10.w, color: Colors.transparent),
                        BuildSubscribeAvatar(),
                        VerticalDivider(width: 10.w, color: Colors.transparent),
                        BuildSubscribeAvatar(),
                        Spacer(),
                      ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                        bottom: 20.h,
                        top: 20.h,
                      ),
                      width: double.maxFinite,
                      child: Text(
                        T.privilegesTip.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(34.r),
              bottomRight: Radius.circular(34.r),
            ),
            color: Color(0xFFFFF8AB),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(
                  start: 10.w,
                  end: 10.w,
                  bottom: 12.h,
                ),
                width: double.maxFinite,
                child: Text(
                  T.premiumPrivilege.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrivilegeItemWidget(index: 0),
                      Divider(height: 12.h, color: Colors.transparent),
                      PrivilegeItemWidget(index: 1),
                      Divider(height: 12.h, color: Colors.transparent),
                      PrivilegeItemWidget(index: 2),
                      Divider(height: 12.h, color: Colors.transparent),
                      PrivilegeItemWidget(index: 3),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrivilegeItemWidget(index: 4),
                      Divider(height: 12.h, color: Colors.transparent),
                      PrivilegeItemWidget(index: 5),
                      Divider(height: 12.h, color: Colors.transparent),
                      PrivilegeItemWidget(index: 6),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
