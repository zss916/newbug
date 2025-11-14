import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/message/index/message_logic.dart';
import 'package:newbug/page/message/index/widget/build_conversation_list.dart';
import 'package:newbug/page/message/index/widget/small_location_widget.dart';
import 'package:newbug/page/status/no_message_view.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

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
                    logic.toChatServiceAccount();
                  },
                  child: Image.asset(Assets.imgCustomer, width: 36, height: 36),
                ),
              ),

              Container(
                margin: EdgeInsetsDirectional.only(end: 16.w),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    logic.toNotice();
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
              buildTopAnchors(logic: logic),
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
                  child: buildBody(logic.viewState, logic),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///顶部列表
  Widget buildTopAnchors({required MessageLogic logic}) => Container(
    padding: EdgeInsetsDirectional.only(top: 14),
    width: double.maxFinite,
    height: 130,
    child: CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverPadding(padding: EdgeInsetsDirectional.only(start: 14.w)),
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () {
              EventService.to.post(MainTab(tab: 1));
            },
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 79,
                      height: 79,
                      alignment: AlignmentDirectional.bottomStart,
                      child: UnconstrainedBox(
                        child: Container(
                          width: 74,
                          height: 74,
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsetsDirectional.all(0),
                          decoration: logic.likesAvatar.isEmpty
                              ? BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  image: DecorationImage(
                                    image: ExactAssetImage(Assets.imgMsgLikes),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                )
                              : BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      logic.likesAvatar,
                                    ),
                                  ),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(12),
                                ),
                        ),
                      ),
                    ),
                    if (logic.wlmNewNum > 0)
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
                            "${logic.wlmNewNum}",
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
                      alignment: AlignmentDirectional.bottomStart,
                      child: UnconstrainedBox(
                        child: Container(
                          width: 74,
                          height: 74,
                          margin: EdgeInsetsDirectional.all(0),
                          decoration: logic.visitorAvatar.isEmpty
                              ? BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  image: DecorationImage(
                                    image: ExactAssetImage(
                                      Assets.imgMsgVisitor,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                )
                              : BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      logic.visitorAvatar,
                                    ),
                                  ),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(12),
                                ),
                        ),
                      ),
                    ),
                    if (logic.visitorNewNum > 0)
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
                              "${logic.visitorNewNum}",
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
        if (logic.newMatchList.isNotEmpty)
          SliverList.separated(
            itemCount: logic.newMatchList.length,
            itemBuilder: (context, index) {
              RCIMIWConversation rCIMIWConversation = logic.newMatchList[index];
              UserEntity? userInfo =
                  logic.userInfoMap[rCIMIWConversation.targetId];
              return Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: 79,
                        height: 79,
                        alignment: AlignmentDirectional.bottomStart,
                        child: UnconstrainedBox(
                          child: Container(
                            width: 74,
                            height: 74,
                            margin: EdgeInsetsDirectional.all(0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  userInfo?.headimg ?? "",
                                ),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Spacer(),
                                if (userInfo?.isShowAddress ?? false)
                                  SmallLocationWidget(
                                    address: userInfo?.address ?? "",
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (userInfo?.isOnline ?? false)
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
                      userInfo?.nickName ?? "",
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

  Widget buildBody(int viewState, MessageLogic logic) {
    return switch (viewState) {
      _ when viewState == 0 => BuildConversationList(
        isNetLoss: logic.isConnectError,
        logic: logic,
      ),
      _ when viewState == 1 => NoMessageView(),
      _ when viewState == 2 => Center(
        child: CircularProgressIndicator(color: Color(0xFFFF0092)),
      ),
      _ => SizedBox.shrink(),
    };
  }
}
