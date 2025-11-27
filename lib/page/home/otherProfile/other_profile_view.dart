import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/home/index/widget/home_about_me.dart';
import 'package:newbug/page/home/index/widget/home_card.dart';
import 'package:newbug/page/home/index/widget/home_interests.dart';
import 'package:newbug/page/home/otherProfile/other_profile_logic.dart';
import 'package:newbug/page/home/otherProfile/widget/other_profile.dart';
import 'package:newbug/page/home/otherProfile/widget/swiper_and_play_widget.dart';

class OtherProfileView extends StatelessWidget {
  const OtherProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        actions: [
          Container(
            margin: EdgeInsetsDirectional.only(start: 10.w, end: 4.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  /* showChatMoreSheet(
                  onViewProfile: () {
                    logic.toViewProfile();
                  },
                  onDelete: () {
                    logic.toDelete();
                  },
                  onReport: () {
                    logic.toReport();
                  },
                  onBlock: () {
                    logic.toBlock();
                  },
                );*/
                },
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: 12.h,
                    horizontal: 10.w,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(Assets.imgMore, width: 24.r, height: 24.r),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: GetBuilder<OtherProfileLogic>(
        init: OtherProfileLogic(),
        builder: (logic) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildCard(medias: logic.mediaList, logic: logic),
                      OtherProfile(item: logic.value),
                      HomeAboutMe(sign: logic.value?.sign ?? ""),
                      HomeInterests(tags: logic.value?.tags ?? []),
                      Divider(height: 20.h, color: Colors.transparent),
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsetsDirectional.only(
                  start: 14.w,
                  end: 14.w,
                  top: 10.h,
                  bottom: 30.h,
                ),
                width: double.maxFinite,
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {
                        //onNext.call();
                      },
                      child: Image.asset(
                        Assets.imgHomeClose,
                        width: 48,
                        height: 48,
                      ),
                    ),
                    VerticalDivider(width: 9.w, color: Colors.transparent),
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {
                        //onLike.call();
                      },
                      child: Image.asset(
                        Assets.imgFabLike,
                        width: 48,
                        height: 48,
                      ),
                    ),
                    VerticalDivider(width: 22.w, color: Colors.transparent),

                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          // onChat.call();
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minWidth: 152),
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFFF0092),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsetsDirectional.only(end: 3),
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
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  height: 1.29,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCard({
    required List<MediaListItem> medias,
    required OtherProfileLogic logic,
  }) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        HomeCard(
          isLoading: logic.loading,
          margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w),
          child: SwiperAndPlayWidget(items: medias),
        ),
      ],
    );
  }
}
