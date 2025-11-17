import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/constants.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/home/index/widget/home_more.dart';
import 'package:newbug/page/home/index/widget/home_sc_listener.dart';
import 'package:newbug/page/home/index/widget/pageview_widget.dart';
import 'package:newbug/page/home/unmatch/unmatch_view.dart';
import 'package:newbug/page/status/no_more_view.dart';
import 'package:newbug/page/status/wrong_view.dart';

import 'home_logic.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
      init: HomeLogic(),
      builder: (logic) {
        return Scaffold(
          appBar: CommonAppBar(
            backgroundColor: Color(0xFFFAFAFA),
            leading: SizedBox.shrink(),
            surfaceTintColor: Colors.white,
            leadingWidth: 0,
            titleWidget: Text(
              App.name,
              style: TextStyle(
                color: const Color(0xFF262626),
                fontSize: 26,
                fontFamily: AppFonts.font1,
              ),
            ),
            centerTitle: false,
            actions: logic.viewState == 0
                ? [
                    HomeMore(
                      onBlock: () {
                        logic.toBlock();
                      },
                      onReport: () {
                        logic.toReport();
                      },
                    ),
                  ]
                : [],
          ),
          backgroundColor: Color(0xFFFAFAFA),
          body: buildBody(viewState: logic.viewState, logic: logic),
        );
      },
    );
  }

  Widget buildBody({required int viewState, required HomeLogic logic}) {
    return switch (viewState) {
      _ when viewState == 0 => HomeScListener(
        builder: (_, controller) => buildContent(controller, true, logic),
        onScrollEnd: (isShow) {
          EventService.to.post(HomeMenuEvent(isShow: isShow));
        },
      ),
      _ when viewState == 1 => WrongView(
        onTap: () {
          logic.loadData();
        },
      ),
      _ when viewState == 2 => NoMoreView(),
      _ when viewState == 3 => UnMatchView(data: logic.privacyList),
      _ when viewState == 4 => Center(
        child: CircularProgressIndicator(color: Color(0xFFFF0092)),
      ),
      _ => HomeScListener(
        builder: (_, controller) => buildContent(controller, true, logic),
        onScrollEnd: (isShow) {
          EventService.to.post(HomeMenuEvent(isShow: isShow));
        },
      ),
    };
  }

  Widget buildContent(
    ScrollController controller,
    bool isShowBottomMenu,
    HomeLogic logic,
  ) {
    return PageViewWidget(
      controller: controller,
      isShowBottomMenu: isShowBottomMenu,
      logic: logic,
    );
  }
}
