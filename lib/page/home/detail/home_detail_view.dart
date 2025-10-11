import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/home/detail/widget/greeting_list.dart';
import 'package:newbug/page/home/detail/widget/input_send.dart';
import 'package:newbug/page/home/detail/widget/intro_widget.dart';
import 'package:newbug/page/home/detail/widget/message_item_widget.dart';
import 'package:newbug/page/home/index/widget/home_card.dart';
import 'package:newbug/page/home/index/widget/home_profile.dart';
import 'package:newbug/page/home/index/widget/swiper_and_play_widget.dart';

class HomeDetailView extends StatelessWidget {
  const HomeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notTitleAppBar,
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildCard(),
                  HomeProfile(),
                  buildDetailItem(state: 1),
                ],
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsetsDirectional.only(
              start: 14.w,
              end: 14.w,
              top: 10.h,
              bottom: 10.h,
            ),
            width: double.maxFinite,
            child: InputSend(
              onSend: (value) {
                ///
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        HomeCard(
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
        ),
        PositionedDirectional(
          bottom: 10,
          end: 10,
          child: InkWell(
            onTap: () => Get.back(),
            child: Image.asset(Assets.imgHomeClose, width: 70, height: 70),
          ),
        ),
      ],
    );
  }

  Widget buildDetailItem({required int state}) {
    return switch (state) {
      _ when state == 0 => GreetingList(),
      _ when state == 1 => IntroWidget(),
      _ when state == 2 => MessageItemWidget(),
      _ => SizedBox.shrink(),
    };
  }
}
