import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/page/like/like_logic.dart';
import 'package:newbug/page/like/widget/title_tab.dart';
import 'package:newbug/page/like/widget/wlm_list_view.dart';
import 'package:newbug/page/like/widget/you_liked_view.dart';
import 'package:newbug/page/status/follow_empty_view.dart';
import 'package:newbug/page/status/incognito_view.dart';
import 'package:newbug/page/status/match_view.dart';
import 'package:newbug/page/status/wrong_view.dart';

class LikeBody extends StatefulWidget {
  final LikeLogic logic;
  const LikeBody({super.key, required this.logic});

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
            logic: widget.logic,
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
              buildLikeContent(
                viewState: widget.logic.wlmViewState,
                logic: widget.logic,
              ),
              buildLikedContent(
                viewState: widget.logic.youLikedViewState,
                logic: widget.logic,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLikeContent({required int viewState, required LikeLogic logic}) {
    return switch (viewState) {
      _ when viewState == 0 => WlmListView(logic: logic),
      _ when viewState == 1 => MatchView(
        onTap: () {
          EventService.to.post(MainTab(tab: 0));
        },
        onImprove: () {
          RouteManager.toEditProfile();
        },
        bottomPadding: 100.h,
      ),
      _ when viewState == 2 => WrongView(
        onTap: () {
          logic.refreshData();
        },
        bottomPadding: 100.h,
      ),
      _ => SizedBox.shrink(),
    };
  }

  Widget buildLikedContent({required int viewState, required LikeLogic logic}) {
    return switch (viewState) {
      _ when viewState == 0 => YouLikedView(logic: logic),
      _ when viewState == 1 => FollowEmptyView(
        onTap: () {
          EventService.to.post(MainTab(tab: 0));
        },
        bottomPadding: 100.h,
      ),
      _ when viewState == 2 => IncognitoView(bottomPadding: 100.h),
      _ => SizedBox.shrink(),
    };
  }
}
