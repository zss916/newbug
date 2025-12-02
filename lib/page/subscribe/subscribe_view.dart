import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/constants.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/subscribe/subscribe_logic.dart';
import 'package:newbug/page/subscribe/widget/build_subscribe_item.dart';
import 'package:newbug/page/subscribe/widget/common_membership_widget.dart';
import 'package:newbug/page/subscribe/widget/payment_tip.dart';
import 'package:newbug/page/subscribe/widget/subscribe_button.dart';
import 'package:newbug/page/subscribe/widget/subscribe_tip.dart';

class SubscribeView extends StatefulWidget {
  const SubscribeView({super.key});

  @override
  State<SubscribeView> createState() => _SubscribeViewState();
}

class _SubscribeViewState extends State<SubscribeView> {
  final ScrollController _scrollController = ScrollController();
  late VoidCallback listener;
  double alphaValue = 0.0;

  @override
  void initState() {
    super.initState();
    listener = () {
      double position = _scrollController.offset;
      setState(() {
        alphaValue = position / (Get.statusBarHeight);
      });
    };
    _scrollController.addListener(listener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        backgroundColor: Color(0xFFFFEE30).withValues(alpha: alphaValue),
        leading: SizedBox.shrink(),
        surfaceTintColor: Colors.white,
        leadingWidth: 0,
        titleWidget: Text(
          T.subscribeTitle.trArgs([App.name]),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF262626),
            fontSize: 21,
            fontFamily: AppFonts.font1,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsetsDirectional.only(start: 0.w, end: 16.w),
            child: InkWell(
              onTap: () => Get.back(),
              child: Image.asset(Assets.imgClosePage, width: 30, height: 30),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: GetBuilder<SubscribeLogic>(
        init: SubscribeLogic(),
        builder: (logic) {
          return NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    ///普通
                    SliverToBoxAdapter(
                      child: CommonMembershipWidget(
                        isExpire: true,
                        isRecharge: false,
                      ),
                    ),

                    ///小号
                    //SliverToBoxAdapter(child: SpecialMembershipWidget()),
                  ];
                },
            body: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEFEFEF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34.r),
                  topRight: Radius.circular(34.r),
                ),
              ),
              margin: EdgeInsetsDirectional.only(
                start: 6.w,
                end: 6.w,
                top: 0.h,
              ),
              width: double.maxFinite,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    BuildSubscribeItem(),
                    SubscribeButton(onTap: () {}),
                    PaymentTip(),
                    SubscribeTip(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
