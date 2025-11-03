import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/widget/app_blur_widget.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/page/message/visitor/visitor_logic.dart';

class BuildVisitorsList extends StatelessWidget {
  final VisitorLogic logic;
  const BuildVisitorsList({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsetsDirectional.only(
        start: 14.w,
        end: 14.w,
        top: 14.w,
        bottom: 14.h,
      ),
      shrinkWrap: true,
      itemCount: logic.data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 174 / 232,
      ),
      itemBuilder: (context, index) {
        PeopleEntity item = logic.data[index];
        return buildBlurItem(item: item, isVip: logic.isUserVip);
      },
    );
  }

  Widget buildBlurItem({required PeopleEntity item, required bool isVip}) =>
      Container(
        clipBehavior: Clip.hardEdge,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(item.headimg ?? ""),
          ),
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(26.r),
            topEnd: Radius.circular(26.r),
            bottomStart: Radius.circular(26.r),
            bottomEnd: Radius.circular(72.r),
          ),
        ),
        child: AppBlurWidget(
          isBlur: !isVip,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(26.r),
            topEnd: Radius.circular(26.r),
            bottomStart: Radius.circular(26.r),
            bottomEnd: Radius.circular(72.r),
          ),
          sigma: 10,
          foreground: buildContent(item: item, isVip: isVip),
          child: buildContent(item: item, isVip: isVip),
        ),
      );

  Widget buildContent({required PeopleEntity item, required bool isVip}) {
    return Container(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: isVip
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 1],
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.9),
                ],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), Color(0xCC000000)],
              ),
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(26.r),
          topEnd: Radius.circular(26.r),
          bottomStart: Radius.circular(26.r),
          bottomEnd: Radius.circular(72.r),
        ),
      ),
      child: Container(
        padding: EdgeInsetsDirectional.only(
          bottom: 15.h,
          top: 10.h,
          start: 8.w,
          end: 8.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                isVip
                    ? Container(
                        constraints: BoxConstraints(maxWidth: 100.w),
                        child: Text(
                          "${item.nickName ?? ""},${item.age}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Container(
                        width: 60.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0x66FFFFFF),
                        ),
                        constraints: BoxConstraints(maxWidth: 100.w),
                      ),
                if (item.isOnline) buildOnline(),
              ],
            ),
            buildLocation(cityName: "${item.location}"),
          ],
        ),
      ),
    );
  }

  ///是否在线
  Widget buildOnline() {
    return Container(
      alignment: AlignmentDirectional.center,
      margin: EdgeInsetsDirectional.only(start: 5.w),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: ShapeDecoration(
        color: const Color(0xFF262626),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(480.18),
        ),
      ),
      child: Text(
        T.online.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFF99FF66),
          fontSize: 9,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  ///定位
  Widget buildLocation({required String cityName}) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 5.h, end: 10.w),
      alignment: AlignmentDirectional.centerStart,
      width: double.maxFinite,
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(end: 2.w),
            child: Image.asset(Assets.imgLocation, width: 12, height: 12),
          ),
          Expanded(
            child: Text(
              cityName,
              //maxLines: 1,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF7D60FF),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
