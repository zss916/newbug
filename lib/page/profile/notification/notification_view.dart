part of 'index.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: T.notification.tr),
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(
              start: 14.w,
              end: 14.w,
              top: 18.h,
              bottom: 8.h,
            ),
            width: double.maxFinite,
            child: Text(
              T.newActivity.tr,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.70),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GetBuilder<NotificationLogic>(
            init: NotificationLogic(),
            builder: (logic) {
              return Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                constraints: BoxConstraints(minHeight: 240.h),
                margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      width: double.maxFinite,
                      height: 60.h,
                      child: Row(
                        children: [
                          Text(
                            T.newMessages.tr,
                            style: TextStyle(
                              color: const Color(0xFF262626),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.20,
                            ),
                          ),
                          Spacer(),
                          AppSwitchWidget(
                            isActive: logic.messagesValue,
                            onChanged: (value) {
                              logic.setPushConfig(0);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, indent: 16.w, color: Color(0xFFF2F2F2)),
                    Container(
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      width: double.maxFinite,
                      height: 60.h,
                      child: Row(
                        children: [
                          Text(
                            T.newMatches.tr,
                            style: TextStyle(
                              color: const Color(0xFF262626),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.20,
                            ),
                          ),
                          Spacer(),
                          AppSwitchWidget(
                            isActive: logic.matchValue,
                            onChanged: (value) {
                              logic.setPushConfig(1);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, indent: 16.w, color: Color(0xFFF2F2F2)),
                    Container(
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      width: double.maxFinite,
                      height: 60.h,
                      child: Row(
                        children: [
                          Text(
                            T.newLikes.tr,
                            style: TextStyle(
                              color: const Color(0xFF262626),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.20,
                            ),
                          ),
                          Spacer(),
                          AppSwitchWidget(
                            isActive: logic.likeValue,
                            onChanged: (value) {
                              logic.setPushConfig(2);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, indent: 16.w, color: Color(0xFFF2F2F2)),
                    Container(
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      width: double.maxFinite,
                      height: 60.h,
                      child: Row(
                        children: [
                          Text(
                            T.newVisitor.tr,
                            style: TextStyle(
                              color: const Color(0xFF262626),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.20,
                            ),
                          ),
                          Spacer(),
                          AppSwitchWidget(
                            isActive: logic.visitorValue,
                            onChanged: (value) {
                              logic.setPushConfig(3);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsetsDirectional.only(top: 10.h),
            padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
            width: double.maxFinite,
            child: Text(
              T.notificationTip.tr,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.50),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
