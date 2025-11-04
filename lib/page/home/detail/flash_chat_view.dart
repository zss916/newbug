import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/home/detail/flash_chat_logic.dart';
import 'package:newbug/page/home/detail/widget/greeting_list.dart';
import 'package:newbug/page/home/detail/widget/input_send.dart';
import 'package:newbug/page/home/detail/widget/intro_widget.dart';
import 'package:newbug/page/home/detail/widget/message_item_widget.dart';
import 'package:newbug/page/home/index/widget/home_card.dart';
import 'package:newbug/page/home/index/widget/home_profile.dart';
import 'package:newbug/page/home/index/widget/swiper_and_play_widget.dart';

class FlashChatView extends StatelessWidget {
  const FlashChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notTitleAppBar,
      backgroundColor: Color(0xFFFAFAFA),
      body: GetBuilder<FlashChatLogic>(
        init: FlashChatLogic(),
        builder: (logic) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildCard(cards: logic.value?.mediaList ?? []),
                      HomeProfile(item: logic.value ?? HomeCardsMatchList()),
                      buildDetailItem(
                        state: 1,
                        value: logic.value ?? HomeCardsMatchList(),
                      ),
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
          );
        },
      ),
    );
  }

  /* Widget buildCard({required List<MediaListItem> cards}) {
    return HomeCard(
      child: SwiperAndPlayWidget(items: [...cards.map((e) => e.imageUrl)]),
    );
  }*/

  Widget buildCard({required List<MediaListItem> cards}) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        HomeCard(child: SwiperAndPlayWidget(items: [...cards])),
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

  Widget buildDetailItem({
    required int state,
    required HomeCardsMatchList value,
  }) {
    return switch (state) {
      _ when state == 0 => GreetingList(),
      _ when state == 1 => IntroWidget(sign: value.sign ?? ""),
      _ when state == 2 => MessageItemWidget(),
      _ => SizedBox.shrink(),
    };
  }
}
