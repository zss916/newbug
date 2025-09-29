import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/like/widget/like_item.dart';
import 'package:newbug/page/like/widget/liked_item.dart';
import 'package:newbug/page/like/widget/title_tab.dart';
import 'package:newbug/page/status/follow_empty_view.dart';
import 'package:newbug/page/status/incognito_view.dart';
import 'package:newbug/page/status/match_view.dart';
import 'package:newbug/page/status/wrong_view.dart';

class LikeBody extends StatefulWidget {
  const LikeBody({super.key});

  @override
  State<LikeBody> createState() => _LikeBodyState();
}

class _LikeBodyState extends State<LikeBody> {
  final PageController pageCtrl = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            top: 4.h,
            bottom: 8.h,
          ),
          width: double.maxFinite,
          child: TitleTab(
            onChange: (index) {
              pageCtrl.jumpToPage(index);
            },
          ),
        ),
        Expanded(
          child: PageView(
            controller: pageCtrl,
            physics: NeverScrollableScrollPhysics(),
            children: [
              buildLikeContent(viewState: 1),
              buildLikedContent(viewState: 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLikeContent({required int viewState}) {
    return switch (viewState) {
      _ when viewState == 0 => SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView.separated(
          itemCount: 20,
          itemBuilder: (context, index) {
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 192,
                    child: ListView.separated(
                      padding: EdgeInsetsDirectional.only(
                        top: 10.h,
                        bottom: 8.h,
                        start: 16.w,
                        end: 16.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return LikeItem(index: index);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          VerticalDivider(
                            width: 8.w,
                            color: Colors.transparent,
                          ),
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
                        VerticalDivider(width: 8.w, color: Colors.transparent),
                        Expanded(
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
      ),
      _ when viewState == 1 => MatchView(bottomPadding: 100.h),
      _ when viewState == 2 => WrongView(bottomPadding: 100.h),
      _ => SizedBox.shrink(),
    };
  }

  Widget buildLikedContent({required int viewState}) {
    return switch (viewState) {
      _ when viewState == 0 => SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView.separated(
          itemCount: 20,
          itemBuilder: (context, index) {
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 192,
                    child: ListView.separated(
                      padding: EdgeInsetsDirectional.only(
                        top: 10.h,
                        bottom: 8.h,
                        start: 16.w,
                        end: 16.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return LikedItem(index: index);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          VerticalDivider(
                            width: 8.w,
                            color: Colors.transparent,
                          ),
                    ),
                  ),
                  Container(
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
                  Divider(height: 8.h, color: Colors.transparent),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>
              Divider(height: 1, color: Color(0xFFEDEDED)),
        ),
      ),
      _ when viewState == 1 => FollowEmptyView(bottomPadding: 100.h),
      _ when viewState == 2 => IncognitoView(bottomPadding: 100.h),
      _ => SizedBox.shrink(),
    };
  }
}
