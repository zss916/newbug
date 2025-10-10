import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/constants.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/subscribe/widget/build_subscribe_item.dart';
import 'package:newbug/page/subscribe/widget/common_membership_widget.dart';
import 'package:newbug/page/subscribe/widget/payment_tip.dart';
import 'package:newbug/page/subscribe/widget/subscribe_button.dart';
import 'package:newbug/page/subscribe/widget/subscribe_tip.dart';
import 'package:newbug/page/subscribe/widget/swiper_item.dart';

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
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: CommonMembershipWidget(isExpire: true, isRecharge: false),
            ),
            // SliverToBoxAdapter(child: SpecialMembershipWidget()),
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
          margin: EdgeInsetsDirectional.only(start: 6.w, end: 6.w, top: 0.h),
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
      ),
    );
  }
}

Widget old() => Scaffold(
  /*  appBar: CommonAppBar(
        backgroundColor: Colors.transparent,
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
      ),*/
  backgroundColor: Colors.white,
  extendBodyBehindAppBar: true,
  body: NestedScrollView(
    // physics: const BouncingScrollPhysics(),
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return [
        SliverAppBar(
          title: Text(
            T.subscribeTitle.trArgs([App.name]),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF262626),
              fontSize: 21,
              fontFamily: AppFonts.font1,
            ),
          ),
          leadingWidth: 16.w,
          leading: SizedBox.shrink(),
          surfaceTintColor: Color(0xFFFFEE30),
          actions: [
            Container(
              margin: EdgeInsetsDirectional.only(start: 0.w, end: 16.w),
              child: InkWell(
                onTap: () => Get.back(),
                child: Image.asset(Assets.imgClosePage, width: 30, height: 30),
              ),
            ),
          ],
          centerTitle: true,
          expandedHeight: 320.h,
          backgroundColor: Colors.transparent,
          pinned: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              margin: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
              decoration: BoxDecoration(
                color: Color(0xFFFFEE30),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(34.r),
                  bottomRight: Radius.circular(34.r),
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  PositionedDirectional(
                    start: 0,
                    top: 0,
                    child: Image.asset(Assets.decorationKing, width: 280),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 240.h,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) =>
                          SwiperItem(index: index),
                      itemCount: 8,
                      autoplay: true,
                      autoplayDelay: 4500,
                      duration: 1000,
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 8.h),
                        builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.black,
                          color: Colors.black.withValues(alpha: 0.20),
                          size: 6,
                          activeSize: 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        /*SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFEE30),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(34.r),
                    bottomRight: Radius.circular(34.r),
                  ),
                ),
                margin: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
                width: double.maxFinite,
                height: 330.h,
                constraints: BoxConstraints(minHeight: 320.h),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    PositionedDirectional(
                      start: 0,
                      top: 0,
                      child: Image.asset(Assets.decorationKing, width: 280),
                    ),
                    PositionedDirectional(
                      bottom: 0,
                      start: 0,
                      end: 0,
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 240.h,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) =>
                              SwiperItem(index: index),
                          itemCount: 8,
                          autoplay: true,
                          autoplayDelay: 4500,
                          duration: 1000,
                          pagination: SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(bottom: 10.h),
                            builder: DotSwiperPaginationBuilder(
                              activeColor: Colors.black,
                              color: Colors.black.withValues(alpha: 0.20),
                              size: 6,
                              activeSize: 6,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
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
      margin: EdgeInsetsDirectional.only(start: 6.w, end: 6.w, top: 0.h),
      width: double.maxFinite,
    ),
  ),
);

Widget old2() => Scaffold(
  appBar: CommonAppBar(
    backgroundColor: Colors.transparent,
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
  body: Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFEE30),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(34.r),
            bottomRight: Radius.circular(34.r),
          ),
        ),
        margin: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
        width: double.maxFinite,
        height: 340.h,
        constraints: BoxConstraints(minHeight: 320.h),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            PositionedDirectional(
              start: 0,
              top: 0,
              child: Image.asset(Assets.decorationKing, width: 280),
            ),
            Column(
              children: [
                Spacer(),
                SizedBox(
                  width: double.maxFinite,
                  height: 240.h,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) =>
                        SwiperItem(index: index),
                    itemCount: 8,
                    autoplay: true,
                    autoplayDelay: 4500,
                    duration: 1000,
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 10.h),
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.black,
                        color: Colors.black.withValues(alpha: 0.20),
                        size: 6,
                        activeSize: 6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                top: 340.h,
              ),
              width: double.maxFinite,
              height: Get.height - Get.statusBarHeight,
              child: Column(children: []),
            ),
          ],
        ),
      ),
    ],
  ),
);

Widget old3() => Scaffold(
  appBar: CommonAppBar(
    backgroundColor: Colors.transparent,
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
  body: NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return [
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFEE30),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(34.r),
                bottomRight: Radius.circular(34.r),
              ),
            ),
            margin: EdgeInsetsDirectional.symmetric(horizontal: 6.w),
            width: double.maxFinite,
            height: 330.h,
            constraints: BoxConstraints(minHeight: 320.h),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                PositionedDirectional(
                  start: 0,
                  top: 0,
                  child: Image.asset(Assets.decorationKing, width: 280),
                ),
                PositionedDirectional(
                  bottom: 0,
                  start: 0,
                  end: 0,
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 240.h,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) =>
                          SwiperItem(index: index),
                      itemCount: 8,
                      autoplay: true,
                      autoplayDelay: 4500,
                      duration: 1000,
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 10.h),
                        builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.black,
                          color: Colors.black.withValues(alpha: 0.20),
                          size: 6,
                          activeSize: 6,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
      margin: EdgeInsetsDirectional.only(start: 6.w, end: 6.w, top: 0.h),
      width: double.maxFinite,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              width: 358,
              height: 93,
              decoration: ShapeDecoration(
                color: const Color(0x0CFF0092),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);
