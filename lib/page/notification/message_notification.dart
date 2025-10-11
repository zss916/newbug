import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/constants.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/notification/overlay_tools.dart';
import 'package:newbug/page/notification/widget/build_avatar.dart';
import 'package:newbug/page/notification/widget/build_location.dart';
import 'package:newbug/page/notification/widget/build_notification_image.dart';
import 'package:overlay_support/overlay_support.dart';

/// 消息通知
void showMessageNotification() {
  OverlayTools.instance.show(
    (context) => SafeArea(
      top: false,
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.up,
        onDismissed: (direction) {
          OverlaySupportEntry.of(context)?.dismiss(animate: false);
        },
        child: MessageNotificationWidget(),
      ),
    ),
  );
}

class MessageNotificationWidget extends StatelessWidget {
  const MessageNotificationWidget({super.key});

  static List<String> get titles => [T.newVisitor.tr, T.newMessages.tr];

  static List<String> get msgContent => [
    T.visitorNotification.tr,
    T.megContentNotification.tr,
    T.photoNotification.tr,
    T.privatePhotosNotification.tr,
    T.privateVideosNotification.tr,
    T.videosNotification.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsetsDirectional.only(top: App.getStatusBarHeight(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.vertical(
          bottom: Radius.circular(24.r),
        ),
        gradient: LinearGradient(
          colors: [Color(0xFF7E61FF), Color(0xFFFF7FC5)],
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PositionedDirectional(
            end: 40,
            bottom: 10,
            child: Image.asset(
              Assets.decorationNotifyBg1,
              width: 43,
              height: 43,
            ),
          ),
          PositionedDirectional(
            end: 30,
            bottom: 63,
            child: Image.asset(
              Assets.decorationNotifyBg1,
              width: 20,
              height: 20,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 202,
                height: 30,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Text(
                  titles[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                child: Row(
                  children: [
                    BuildAvatar(
                      url:
                          "https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
                    ),
                    VerticalDivider(width: 12.w, color: Colors.transparent),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: 160.w),
                                child: Text(
                                  'Mei,35',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              BuildLocation(place: "New York"),
                            ],
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              msgContent[2],
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.90),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BuildNotificationImage(
                      url:
                          "https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
                      isPrivate: true,
                      isVideo: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
