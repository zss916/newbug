import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late final PageController pageCtrl = PageController(initialPage: 0);

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
        return SizedBox(
          width: Get.width,
          height: Get.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [buildBody(), HomeMenu()],
          ),
        );
      },
    );
  }

  Widget buildBody() {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageCtrl,
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
                    child: Image.asset(
                      currentIndex == 1
                          ? Assets.imgLikeActiveIc
                          : Assets.imgLikeIc,
                      width: 27,
                      height: 27,
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
            pageCtrl.jumpToPage(currentIndex);
            EventService.to.post(HomeMenuEvent(isShow: currentIndex == 0));
          });
        },
      ),
    );
  }
}
