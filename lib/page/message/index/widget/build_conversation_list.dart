import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:newbug/page/message/index/message_logic.dart';
import 'package:newbug/page/message/index/utils/message_time_util.dart';
import 'package:newbug/page/message/index/widget/conversation_msg_widget.dart';
import 'package:newbug/page/message/index/widget/net_lose_widget.dart';
import 'package:newbug/page/message/index/widget/red_point.dart';
import 'package:newbug/page/message/index/widget/small_location_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

class BuildConversationList extends StatelessWidget {
  final bool? isNetLoss;
  final MessageLogic logic;
  const BuildConversationList({super.key, this.isNetLoss, required this.logic});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (isNetLoss == true)
          SliverToBoxAdapter(child: NetLoseWidget())
        else
          SliverPadding(padding: EdgeInsetsDirectional.only(top: 14.h)),
        SliverList.separated(
          itemCount: logic.conversationsList.length,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 12.h, color: Colors.transparent),
          itemBuilder: (BuildContext context, int index) {
            RCIMIWConversation rCIMIWConversation =
                logic.conversationsList[index];
            UserEntity? userInfo =
                logic.userInfoMap[rCIMIWConversation.targetId];
            return Slidable(
              key: ValueKey("MsgTag$index"),
              groupTag: "MsgTags",
              enabled: true,
              useTextDirection: true,
              endActionPane: ActionPane(
                extentRatio: 0.4,
                motion: const DrawerMotion(),
                children: [
                  removeAction(rCIMIWConversation),
                  topAction(rCIMIWConversation),
                ],
              ),
              child: InkWell(
                onTap: () {
                  logic.toChat(
                    targetId: rCIMIWConversation.targetId,
                    userInfo: userInfo,
                  );
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
                    color: rCIMIWConversation.top == true
                        ? Color(0xFFFFEBF7)
                        : Color(0xFFF5F3FF),
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
                                  image: CachedNetworkImageProvider(
                                    userInfo?.headimg ?? "",
                                  ),
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            if (userInfo?.isOnline ?? false)
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
                                    constraints: BoxConstraints(
                                      maxWidth: 150.w,
                                    ),
                                    margin: EdgeInsetsDirectional.only(
                                      end: 4.w,
                                    ),
                                    child: Text(
                                      userInfo?.nickName ?? "",
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
                                  if (userInfo?.isShowAddress ?? false)
                                    SmallLocationWidget(
                                      address: userInfo?.address ?? "",
                                    ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsetsDirectional.only(
                                      start: 10.w,
                                    ),
                                    child: Text(
                                      MessageTimeUtil.convertConversationTime(
                                        rCIMIWConversation
                                                .lastMessage
                                                ?.sentTime ??
                                            0,
                                      ),
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
                                Expanded(
                                  child: ConversationMsgWidget(
                                    value: rCIMIWConversation,
                                  ),
                                ),
                                if ((rCIMIWConversation.unreadCount ?? 0) > 0)
                                  RedPoint(
                                    count: rCIMIWConversation.unreadCount ?? 0,
                                  ),
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
            );
          },
        ),
      ],
    );
  }

  ///
  Widget buildList() {
    return SlidableAutoCloseBehavior(
      child: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        onLoading: () {
          //logic.loadMoreConversations();
        },
        controller: logic.loadMoreCtrl,
        child: CustomScrollView(
          slivers: [
            if (isNetLoss == true)
              SliverToBoxAdapter(child: NetLoseWidget())
            else
              SliverPadding(padding: EdgeInsetsDirectional.only(top: 14.h)),
            SliverList.separated(
              itemCount: logic.conversationsList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 12.h, color: Colors.transparent),
              itemBuilder: (BuildContext context, int index) {
                RCIMIWConversation rCIMIWConversation =
                    logic.conversationsList[index];
                UserEntity? userInfo =
                    logic.userInfoMap[rCIMIWConversation.targetId];
                return Slidable(
                  key: ValueKey("MsgTag$index"),
                  groupTag: "MsgTags",
                  enabled: true,
                  useTextDirection: true,
                  endActionPane: ActionPane(
                    extentRatio: 0.4,
                    motion: const DrawerMotion(),
                    children: [
                      removeAction(rCIMIWConversation),
                      topAction(rCIMIWConversation),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      logic.toChat(
                        targetId: rCIMIWConversation.targetId,
                        userInfo: userInfo,
                      );
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
                        color: rCIMIWConversation.top == true
                            ? Color(0xFFFFEBF7)
                            : Color(0xFFF5F3FF),
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
                                      image: CachedNetworkImageProvider(
                                        userInfo?.headimg ?? "",
                                      ),
                                    ),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                if (userInfo?.isOnline ?? false)
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
                                        constraints: BoxConstraints(
                                          maxWidth: 150.w,
                                        ),
                                        margin: EdgeInsetsDirectional.only(
                                          end: 4.w,
                                        ),
                                        child: Text(
                                          userInfo?.nickName ?? "",
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
                                      if (userInfo?.isShowAddress ?? false)
                                        SmallLocationWidget(
                                          address: userInfo?.address ?? "",
                                        ),
                                      Spacer(),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsetsDirectional.only(
                                          start: 10.w,
                                        ),
                                        child: Text(
                                          MessageTimeUtil.convertConversationTime(
                                            rCIMIWConversation
                                                    .lastMessage
                                                    ?.sentTime ??
                                                0,
                                          ),
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
                                    Expanded(
                                      child: ConversationMsgWidget(
                                        value: rCIMIWConversation,
                                      ),
                                    ),
                                    if ((rCIMIWConversation.unreadCount ?? 0) >
                                        0)
                                      RedPoint(
                                        count:
                                            rCIMIWConversation.unreadCount ?? 0,
                                      ),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget removeAction(RCIMIWConversation rCIMIWConversation) {
    return CustomSlidableAction(
      onPressed: (context) {
        logic.removeConversationItem(targetId: rCIMIWConversation.targetId);
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
    );
  }

  Widget topAction(RCIMIWConversation rCIMIWConversation) {
    return CustomSlidableAction(
      onPressed: (context) {
        logic.setConversationItemTop(
          targetId: rCIMIWConversation.targetId,
          isTop: (rCIMIWConversation.top ?? false),
        );
      },
      alignment: Alignment.centerLeft,
      autoClose: true,
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: rCIMIWConversation.top == true
              ? Color(0xFFFFEBF6)
              : Color(0xFFF5F3FF),
          borderRadius: BorderRadius.circular(12),
        ),
        width: 60,
        height: 76,
        child: Image.asset(
          rCIMIWConversation.top == true
              ? Assets.imgIcStopTop
              : Assets.imgIcTop,
          width: 21,
          height: 21,
        ),
      ),
    );
  }
}
