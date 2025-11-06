import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/app_blur_widget.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/message/index/message_logic.dart';
import 'package:newbug/page/message/index/widget/location_widget.dart';
import 'package:newbug/page/message/index/widget/net_lose_widget.dart';
import 'package:newbug/page/message/index/widget/red_point.dart';
import 'package:newbug/page/status/no_message_view.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageLogic>(
      init: MessageLogic(),
      builder: (logic) {
        return Scaffold(
          appBar: CommonAppBar(
            backgroundColor: Color(0xFFF7DEF9),
            leading: SizedBox.shrink(),
            surfaceTintColor: Color(0xFFF7DEF9),
            leadingWidth: 0,
            titleWidget: Text(
              T.message.tr,
              style: TextStyle(
                color: const Color(0xFF262626),
                fontSize: 26,
                fontFamily: AppFonts.font1,
              ),
            ),
            centerTitle: false,
            actions: [
              Container(
                margin: EdgeInsetsDirectional.only(end: 10.w),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    ///
                  },
                  child: Image.asset(Assets.imgCustomer, width: 36, height: 36),
                ),
              ),

              Container(
                margin: EdgeInsetsDirectional.only(end: 16.w),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    ///
                  },
                  child: Image.asset(
                    Assets.imgMessageNotification,
                    width: 36,
                    height: 36,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFFF7DEF9),
          body: Column(
            children: [
              buildTopAnchors(),
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.vertical(
                      top: Radius.circular(33),
                    ),
                  ),
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: buildMessages(),

                  ///child: buildMessageEmpty(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTopAnchors() => Container(
    padding: EdgeInsetsDirectional.only(top: 14),
    width: double.maxFinite,
    height: 130,
    child: CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverPadding(padding: EdgeInsetsDirectional.only(start: 14.w)),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: 79,
                    height: 79,
                    // color: Colors.blue,
                    alignment: AlignmentDirectional.bottomStart,
                    child: UnconstrainedBox(
                      child: Container(
                        width: 74,
                        height: 74,
                        margin: EdgeInsetsDirectional.all(0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          image: DecorationImage(
                            image: ExactAssetImage(Assets.imgMsgLikes),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  if (true)
                    PositionedDirectional(
                      top: 0,
                      end: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "1",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Divider(height: 6.h, color: Colors.transparent),
              Text(
                T.likes.tr,
                style: TextStyle(
                  color: const Color(0xFF262626),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SliverPadding(padding: EdgeInsetsDirectional.only(start: 10.w)),
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () {
              RouteManager.toVisitor(isUserVip: false);
            },
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 79,
                      height: 79,
                      //color: Colors.blue,
                      alignment: AlignmentDirectional.bottomStart,
                      child: UnconstrainedBox(
                        child: Container(
                          width: 74,
                          height: 74,
                          margin: EdgeInsetsDirectional.all(0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            image: DecorationImage(
                              image: ExactAssetImage(Assets.imgMsgVisitor),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    if (true)
                      PositionedDirectional(
                        top: 0,
                        end: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: FittedBox(
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Divider(height: 6.h, color: Colors.transparent),
                Text(
                  T.visitor.tr,
                  style: TextStyle(
                    color: const Color(0xFF262626),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(padding: EdgeInsetsDirectional.only(start: 10.w)),
        SliverList.separated(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 79,
                      height: 79,
                      // color: Colors.blue,
                      alignment: AlignmentDirectional.bottomStart,
                      child: UnconstrainedBox(
                        child: Container(
                          width: 74,
                          height: 74,
                          margin: EdgeInsetsDirectional.all(0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
                              ),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                  start: 3.w,
                                  end: 3.w,
                                  bottom: 4.h,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 3.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF7DEF9),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.80,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      Assets.imgLocation,
                                      width: 11,
                                      height: 11,
                                    ),
                                    Text(
                                      'New York',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: const Color(0xFF7D60FF),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (true)
                      PositionedDirectional(
                        top: 2,
                        end: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Color(0xFF18CD00),
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                  ],
                ),
                Divider(height: 6.h, color: Colors.transparent),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 4.w, end: 4.w),
                  width: 74,
                  child: Text(
                    "name$index",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF262626),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              VerticalDivider(width: 10.w, color: Colors.transparent),
        ),
      ],
    ),
  );

  Widget buildMessagesList() => ListView.separated(
    padding: EdgeInsetsDirectional.only(top: 14.h, bottom: 76),
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return Slidable(
        key: ValueKey("MsgTag$index"),
        groupTag: "MsgTags",
        enabled: true,
        useTextDirection: true,
        endActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const DrawerMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (context) {
                // widget.onDelete.call();
              },
              alignment: Alignment.centerLeft,
              autoClose: true,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                alignment: AlignmentDirectional.center,
                width: 60,
                height: 76,
                child: Image.asset(Assets.imgIcRemove, width: 24, height: 24),
              ),
            ),
            CustomSlidableAction(
              onPressed: (context) {
                // widget.onDelete.call();
              },
              alignment: Alignment.centerLeft,
              autoClose: true,
              backgroundColor: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index == 0 ? Color(0xFFFFEBF6) : Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: 60,
                height: 76,
                child: Image.asset(
                  index == 0 ? Assets.imgIcStopTop : Assets.imgIcTop,
                  width: 21,
                  height: 21,
                ),
              ),
            ),
          ],
        ),
        child: Container(
          width: double.maxFinite,
          height: 76,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 8.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: index == 0 ? Color(0xFFFFEBF7) : Color(0xFFF5F3FF),
          ),
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(end: 8.w),
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
                          ),
                        ),
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    if (true)
                      PositionedDirectional(
                        top: 0,
                        end: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Color(0xFF18CD00),
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        verticalDirection: VerticalDirection.up,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 150.w),
                            margin: EdgeInsetsDirectional.only(end: 4.w),
                            child: Text(
                              'Lily,37ddddsfdsfdsf',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              // overflow: TextOverflow.e,
                              style: TextStyle(
                                color: const Color(0xFF262626),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          LocationWidget(),
                          Spacer(),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsetsDirectional.only(start: 10.w),
                            child: Text(
                              '12:00',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF606266),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Container(
                          margin: EdgeInsetsDirectional.only(end: 6.w),
                          child: AppBlurWidget(
                            isBlur: true,
                            sigma: 1.5,
                            borderRadius: BorderRadius.circular(6),
                            foreground: Image.asset(
                              Assets.imgLock,
                              width: 14.w,
                              height: 14.w,
                            ),
                            child: Container(
                              width: 24,
                              height: 20,
                              clipBehavior: Clip.hardEdge,
                              foregroundDecoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'How about if we go tomorrow instead? ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: const Color(0xFF494949),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        RedPoint(count: 1),
                        SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) =>
        Divider(height: 12.h, color: Colors.transparent),
  );

  Widget buildMessages() => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(child: NetLoseWidget()),
      SliverList.separated(
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 12.h, color: Colors.transparent),
        itemBuilder: (BuildContext context, int index) => Slidable(
          key: ValueKey("MsgTag$index"),
          groupTag: "MsgTags",
          enabled: true,
          useTextDirection: true,
          endActionPane: ActionPane(
            extentRatio: 0.4,
            motion: const DrawerMotion(),
            children: [
              CustomSlidableAction(
                onPressed: (context) {
                  // widget.onDelete.call();
                },
                alignment: Alignment.centerLeft,
                autoClose: true,
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  alignment: AlignmentDirectional.center,
                  width: 60,
                  height: 76,
                  child: Image.asset(Assets.imgIcRemove, width: 24, height: 24),
                ),
              ),
              CustomSlidableAction(
                onPressed: (context) {
                  // widget.onDelete.call();
                },
                alignment: Alignment.centerLeft,
                autoClose: true,
                backgroundColor: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index == 0 ? Color(0xFFFFEBF6) : Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: 60,
                  height: 76,
                  child: Image.asset(
                    index == 0 ? Assets.imgIcStopTop : Assets.imgIcTop,
                    width: 21,
                    height: 21,
                  ),
                ),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              RouteManager.toChat();
            },
            child: Container(
              width: double.maxFinite,
              height: 76,
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 8.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: index == 0 ? Color(0xFFFFEBF7) : Color(0xFFF5F3FF),
              ),
              margin: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 8.w),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
                              ),
                            ),
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        if (true)
                          PositionedDirectional(
                            top: 0,
                            end: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Color(0xFF18CD00),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            verticalDirection: VerticalDirection.up,
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: 150.w),
                                margin: EdgeInsetsDirectional.only(end: 4.w),
                                child: Text(
                                  'Lily,37ddddsfdsfdsf',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  // overflow: TextOverflow.e,
                                  style: TextStyle(
                                    color: const Color(0xFF262626),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              LocationWidget(),
                              Spacer(),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsetsDirectional.only(start: 10.w),
                                child: Text(
                                  '12:00',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF606266),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(end: 6.w),
                              child: AppBlurWidget(
                                isBlur: true,
                                sigma: 1.5,
                                borderRadius: BorderRadius.circular(6),
                                foreground: Image.asset(
                                  Assets.imgLock,
                                  width: 14.w,
                                  height: 14.w,
                                ),
                                child: Container(
                                  width: 24,
                                  height: 20,
                                  clipBehavior: Clip.hardEdge,
                                  foregroundDecoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "https://img1.baidu.com/it/u=3311890800,2189225060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1000",
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'How about if we go tomorrow instead? ',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: const Color(0xFF494949),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            RedPoint(count: 1),
                            SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget buildMessageEmpty() => NoMessageView();
}
