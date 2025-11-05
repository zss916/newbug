import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/people_entity.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/page/like/like_logic.dart';
import 'package:newbug/page/like/widget/like_item.dart';

class WlmListView extends StatelessWidget {
  final LikeLogic logic;
  const WlmListView({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: ListView.separated(
        itemCount: logic.wlmList.length,
        itemBuilder: (context, index) {
          PeopleEntity item = logic.wlmList[index];
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
                      return LikeItem(
                        index: index,
                        item: item,
                        subItem: subitem,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        VerticalDivider(width: 8.w, color: Colors.transparent),
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            alignment: AlignmentDirectional.center,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF0EDFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image.asset(
                                  Assets.imgLikeNext,
                                  width: 34,
                                  height: 34,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(width: 8.w, color: Colors.transparent),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            alignment: AlignmentDirectional.center,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF7E61FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image.asset(
                                  Assets.imgLikeFollow,
                                  width: 34,
                                  height: 34,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
