import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/mixin/delayed_init_mixin.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/home/index/home_view.dart';
import 'package:newbug/page/home/index/widget/home_menu.dart';
import 'package:newbug/page/like/like_view.dart';
import 'package:newbug/page/main/main_logic.dart';
import 'package:newbug/page/main/widget/message_tip_bubble.dart';
import 'package:newbug/page/message/index/message_view.dart';
import 'package:newbug/page/message/index/widget/red_point.dart';
import 'package:newbug/page/profile/index/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with DelayedInitMixin {
  int currentIndex = 0;
  StreamSubscription<MainTab>? subs;

  @override
  void initState() {
    super.initState();
    subs = EventService.to.listen<MainTab>((event) {
      setState(() {
        currentIndex = event.tab;
      });
    });
  }

  @override
  void dispose() {
    subs?.cancel();
    super.dispose();
  }

  @override
  void afterFirstLayout() {
    //Get.sheet(GuideView());
    //(Get.arguments as bool);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLogic>(
      init: MainLogic(),
      builder: (logic) {
        return SizedBox.expand(
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              buildBody(logic),
              HomeMenu(tabIndex: currentIndex),
            ],
          ),
        );
      },
    );
  }

  Widget buildBody(MainLogic logic) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: IndexedStack(
        index: currentIndex,
        children: [HomeView(), LikeView(), MessageView(), ProfileView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  alignment: AlignmentDirectional.center,
                  child: UnconstrainedBox(
                    child: Image.asset(
                      currentIndex == 0
                          ? Assets.imgCardActiveIc
                          : Assets.imgCardIc,
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
              ],
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  alignment: AlignmentDirectional.center,
                  child: UnconstrainedBox(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          currentIndex == 1
                              ? Assets.imgLikeActiveIc
                              : Assets.imgLikeIc,
                          width: 27,
                          height: 27,
                        ),
                        if (logic.wlmNewNum > 0)
                          PositionedDirectional(
                            top: 0,
                            end: 0,
                            child: RedPoint(count: logic.wlmNewNum),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: MessageTipBubble(
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    alignment: AlignmentDirectional.center,
                    child: UnconstrainedBox(
                      child: Image.asset(
                        currentIndex == 2
                            ? Assets.imgMessageActiveIc
                            : Assets.imgMessageIc,
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: RedPoint(count: 1),
                  ),
                ],
              ),
            ),
            /* icon: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  alignment: AlignmentDirectional.center,
                  child: UnconstrainedBox(
                    child: Image.asset(
                      currentIndex == 2
                          ? Assets.imgMessageActiveIc
                          : Assets.imgMessageIc,
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: RedPoint(count: 1),
                ),
              ],
            ),*/
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  alignment: AlignmentDirectional.center,
                  child: UnconstrainedBox(
                    child: Image.asset(
                      currentIndex == 3
                          ? Assets.imgUserActiveIc
                          : Assets.imgUserIc,
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
        ],
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
