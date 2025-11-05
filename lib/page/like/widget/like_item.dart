import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/like/widget/like_avatar.dart';
import 'package:newbug/page/like/widget/like_blur_widget.dart';
import 'package:newbug/page/like/widget/like_left.dart';
import 'package:newbug/page/like/widget/like_new_label.dart';
import 'package:newbug/page/location/location_utils.dart';

class LikeItem extends StatelessWidget {
  final int index;
  final PeopleEntity item;
  final MediaListItem subItem;
  final bool? isVip;
  const LikeItem({
    super.key,
    required this.index,
    required this.item,
    required this.subItem,
    this.isVip,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 144 / 192,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(subItem.imageUrl),
            fit: BoxFit.cover,
          ),
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? Radius.circular(22.r) : Radius.circular(8.r),
            topRight: index == 0 ? Radius.circular(22.r) : Radius.circular(8.r),
            bottomLeft: index == 0
                ? Radius.circular(22.r)
                : Radius.circular(8.r),
            bottomRight: index == 0
                ? Radius.circular(59.r)
                : Radius.circular(8.r),
          ),
        ),
        height: double.maxFinite,
        child: LikeBlurWidget(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(46, 42, 45, 0),
                Color.fromRGBO(46, 42, 45, 0),
                Color.fromRGBO(46, 42, 45, 1),
              ],
            ),
          ),
          isBlur: (isVip ?? (AppStores.getUserInfo()?.isVip ?? false))
              ? false
              : true,
          index: index,
          child: index == 0 ? buildFirstItem(item) : buildOtherItem(subItem),
        ),
      ),
    );
  }

  Widget buildFirstItem(PeopleEntity item) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LikeAvatar(item: item),
      if (item.isNew)
        LikeNewLabel(margin: EdgeInsetsDirectional.only(top: 6.h)),
      Container(
        margin: EdgeInsetsDirectional.only(top: 4.h),
        width: double.maxFinite,
        child: Text(
          '${item.nickName ?? ""},${item.age}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      if (LocationUtils.isShowLocationSync(item.location ?? 0))
        Container(
          margin: EdgeInsetsDirectional.only(top: 3.h),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
          decoration: ShapeDecoration(
            color: const Color(0xFFF7DEF9),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.80,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(end: 2.w),
                child: Image.asset(
                  Assets.imgLocation,
                  width: 11.r,
                  height: 11.r,
                ),
              ),
              Container(
                constraints: BoxConstraints(minWidth: 20.w, maxWidth: 100.w),
                child: Text(
                  (LocationUtils.getCacheLocationInfo()?.address ?? "").isEmpty
                      ? "--"
                      : LocationUtils.getCacheLocationInfo()?.address ?? "--",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF7D60FF),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      Spacer(),
      if ((item.timeOut ?? "").isNotEmpty)
        LikeLeft(timeOut: item.timeOut ?? ""),
    ],
  );

  Widget buildOtherItem(MediaListItem subItem) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (subItem.isPrivateMedia)
        Image.asset(Assets.imgLikeWild, width: 37, height: 37),
      Divider(height: 10.h, color: Colors.transparent),
      if (subItem.isPrivateMedia)
        Text(
          T.wildPhoto.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            height: 1.14,
          ),
        ),
    ],
  );
}
