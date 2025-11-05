import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/page/like/like_logic.dart';
import 'package:newbug/page/like/widget/liked_item.dart';

class YouLikedView extends StatelessWidget {
  final LikeLogic logic;
  const YouLikedView({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: ListView.separated(
        itemCount: logic.youLikedList.length,
        itemBuilder: (context, index) {
          PeopleEntity item = logic.youLikedList[index];
          List<MediaListItem> list = item.mediaList ?? [];
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 192,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsetsDirectional.only(
                      top: 10.h,
                      bottom: 8.h,
                      start: 16.w,
                      end: 16.w,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      MediaListItem subitem = list[index];
                      return LikedItem(
                        index: index,
                        item: item,
                        subItem: subitem,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        VerticalDivider(width: 8.w, color: Colors.transparent),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ///todo
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    width: double.maxFinite,
                    child: Container(
                      width: double.infinity,
                      height: 44,
                      alignment: AlignmentDirectional.center,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF0092),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(end: 3.w),
                            child: Image.asset(
                              Assets.imgMsgIc,
                              width: 26,
                              height: 26,
                            ),
                          ),
                          Text(
                            T.chatNow.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.29,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(height: 8.h, color: Colors.transparent),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Color(0xFFEDEDED)),
      ),
    );
  }
}
