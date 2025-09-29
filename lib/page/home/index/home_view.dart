import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/config/constants.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/dialog/love/dialog_love.dart' show showLoveDialog;
import 'package:newbug/page/dialog/next/dialog_next.dart';
import 'package:newbug/page/dialog/trun_on_notification.dart';
import 'package:newbug/page/dialog/wild_photo.dart';
import 'package:newbug/page/home/index/widget/home_about_me.dart';
import 'package:newbug/page/home/index/widget/home_bottom_menu.dart';
import 'package:newbug/page/home/index/widget/home_card.dart';
import 'package:newbug/page/home/index/widget/home_interests.dart';
import 'package:newbug/page/home/index/widget/home_more.dart';
import 'package:newbug/page/home/index/widget/home_profile.dart';
import 'package:newbug/page/home/index/widget/home_sc_listener.dart';
import 'package:newbug/page/home/index/widget/swiper_and_play_widget.dart';
import 'package:newbug/page/status/no_more_view.dart';
import 'package:newbug/page/status/wrong_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
        actions: [
          HomeMore(
            onBlock: () {
              showTurnOnNotification();
            },
            onReport: () {
              showWildPhoto();
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: buildBody(viewState: -1),
    );
  }

  Widget buildBody({required int viewState}) {
    return switch (viewState) {
      _ when viewState == 0 => WrongView(),
      _ when viewState == 1 => NoMoreView(),
      _ => HomeScListener(
        builder: (_, controller) => buildContent(controller, true),
        onScrollEnd: (isShow) {
          EventService.to.post(HomeMenuEvent(isShow: isShow));
        },
      ),
    };
  }

  Widget buildCard() {
    return HomeCard(
      child: SwiperAndPlayWidget(
        items: [
          "https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
          "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
          "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
          "https://img1.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
          "https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666",
          "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
        ],
      ),
    );
  }

  Widget buildContent(ScrollController controller, bool isShowBottomMenu) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          buildCard(),
          HomeProfile(),
          HomeAboutMe(),
          HomeInterests(),
          if (isShowBottomMenu)
            HomeBottomMenu(
              onChat: () {
                //todo
              },
              onNext: () {
                showNextDialog();
              },
              onLike: () {
                showLoveDialog();
              },
            )
          else
            SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
