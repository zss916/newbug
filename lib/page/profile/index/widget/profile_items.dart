import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/services/app_config_service.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/dialog/help/sheet_account.dart';
import 'package:newbug/page/dialog/help/sheet_help_center.dart';
import 'package:newbug/page/profile/index/profile_logic.dart';

class ProfileItems extends StatelessWidget {
  final ProfileLogic logic;
  const ProfileItems({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 360.h),
      margin: EdgeInsetsDirectional.only(
        start: 14.w,
        end: 14.w,
        top: 14.h,
        bottom: 100.h,
      ),
      width: double.maxFinite,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: <Widget>[
          buildItem(
            icon: Assets.imgIcAccount,
            title: T.account.tr,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            onTap: () {
              showAccountSheet(
                onLogOut: () {
                  logic.toLogOUt();
                },
              );
            },
          ),

          Divider(height: 1, color: Color(0xFFF2F2F2)),

          buildItem(
            icon: Assets.imgIcNotification,
            title: T.notification.tr,
            borderRadius: BorderRadius.zero,
            onTap: () {
              RouteManager.toNotification();
            },
          ),

          Divider(height: 1, color: Color(0xFFF2F2F2)),

          buildItem(
            icon: Assets.imgIcHelp,
            title: T.helpCenter.tr,
            iconSize: Offset(22, 22),
            borderRadius: BorderRadius.zero,
            onTap: () {
              showHelpCenterSheet();
            },
          ),

          Divider(height: 1, color: Color(0xFFF2F2F2)),

          buildItem(
            icon: Assets.imgIcPolicy,
            title: T.privacyPolicy.tr,
            borderRadius: BorderRadius.zero,
            onTap: () {
              // AppConfigService.to.toPrivacy();
              RouteManager.towWebview(
                title: T.privacyPolicy.tr,
                url: AppConfigService.to.privacy,
              );
            },
          ),

          Divider(height: 1, color: Color(0xFFF2F2F2)),

          buildItem(
            icon: Assets.imgIcTerms,
            iconSize: Offset(19, 19),
            title: T.terms.tr,
            borderRadius: BorderRadius.zero,
            onTap: () {
              // AppConfigService.to.toTerms();
              RouteManager.towWebview(
                title: T.terms.tr,
                url: AppConfigService.to.terms,
              );
            },
          ),

          Divider(height: 1, color: Color(0xFFF2F2F2)),

          buildItem(
            icon: Assets.imgIcChildPolicy,
            iconSize: Offset(22, 22),
            title: T.childSafetyPolicy.tr,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            onTap: () {
              /*RouteManager.towWebview(
                title: T.childSafetyPolicy.tr,
                url: AppConfigService.to.privacy,
              );*/
            },
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    required String icon,
    required String title,
    required Function onTap,
    Offset? iconSize,
    BorderRadius? borderRadius,
  }) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: borderRadius,
      onTap: () {
        onTap.call();
      },
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 18.h,
        ),
        width: double.maxFinite,
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              alignment: AlignmentDirectional.center,
              margin: EdgeInsetsDirectional.only(end: 10.w),
              child: UnconstrainedBox(
                child: Image.asset(
                  icon,
                  width: iconSize?.dx ?? 24,
                  height: iconSize?.dy ?? 24,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF262626),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Image.asset(Assets.imgArrowEnd, width: 24, height: 24),
          ],
        ),
      ),
    ),
  );
}
