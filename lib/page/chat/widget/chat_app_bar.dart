import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/index.dart';

class ChatAppBar extends StatelessWidget {
  final UserEntity? userInfo;
  final Function? onMoreAction;
  final ChatType? chatType;
  const ChatAppBar({
    super.key,
    required this.userInfo,
    this.chatType,
    this.onMoreAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.maxFinite,
      child: Row(
        children: [
          buildBack(),
          Expanded(child: buildAppBarContent(chatType: chatType)),
        ],
      ),
    );
  }

  Widget buildAppBarContent({ChatType? chatType}) {
    return switch (chatType) {
      _ when chatType == ChatType.officialNotice => Text(
        T.officialNotice.tr,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      _ when chatType == ChatType.customerService => Text(
        T.onlineSupport.tr,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      _ => Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(end: 10.w),
            padding: EdgeInsetsDirectional.symmetric(vertical: 12.h),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        userInfo?.headimg ?? "",
                      ),
                    ),
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                if (userInfo?.isOnline ?? false)
                  PositionedDirectional(
                    top: 1,
                    end: 1,
                    child: Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        color: Color(0xFF18CD00),
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${userInfo?.showNickAndAge}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (userInfo?.isShowAddress ?? false)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.imgLocation,
                        width: 14.r,
                        height: 14.r,
                      ),
                      Text(
                        userInfo?.address ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF7D60FF),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 10.w, end: 4.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  onMoreAction?.call();
                },
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: 12.h,
                    horizontal: 10.w,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(Assets.imgMore, width: 24.r, height: 24.r),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    };
  }

  Widget buildBack() => Container(
    margin: EdgeInsetsDirectional.only(start: 4.w),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => Get.back(),
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            vertical: 12.w,
            horizontal: 10.h,
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(Assets.imgToBack, width: 24.r, height: 24.r),
            ],
          ),
        ),
      ),
    ),
  );
}
