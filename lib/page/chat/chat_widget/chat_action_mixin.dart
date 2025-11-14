import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

mixin class ChatActionMixin {
  /// 它等于0说明列表在底部
  double extentAfter = 0;

  /// 它等于0说明列表在顶部
  double extentBefore = 0;

  ScrollController scrollCtrl = ScrollController();

  ///滑动到列表底部
  void setListScrollToBottom({required List data}) {
    if (data.isEmpty) return;
    Future.delayed(const Duration(milliseconds: 200), () {
      double scrollHeight = scrollCtrl.position.maxScrollExtent;
      double targetPosition = scrollHeight;
      scrollCtrl.jumpTo(targetPosition);
    });
  }

  ///滑动到列表顶部
  void setListScrollToTop({required List data}) {
    if (data.isEmpty) return;
    if (extentBefore == 0) {
      Future.delayed(const Duration(milliseconds: 400), () {
        scrollCtrl.animateTo(
          scrollCtrl.offset - 60.h,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linearToEaseOut,
        );
      });
    }
  }

  ///处理显示发送时间
  List<LocalWrapperMsg> handMsgTime(
    List<RCIMIWMessage> recentMessage,
    int time,
  ) {
    List<LocalWrapperMsg> msgList = recentMessage
        .map(
          (e) => LocalWrapperMsg(
            rCIMIWMessage: e,
            isSender: e.direction == RCIMIWMessageDirection.send,
            targetId: e.targetId,
          ),
        )
        .toList();
    // 遍历wrapper,判断是否显示时间，5分钟
    var ite = msgList.iterator;
    ite.moveNext();
    var wrapperTemp = ite.current;
    wrapperTemp.showTime =
        time - (wrapperTemp.rCIMIWMessage.sentTime ?? 0) > 5 * 60 * 1000;
    while (ite.moveNext()) {
      var current = ite.current;
      current.showTime =
          (wrapperTemp.rCIMIWMessage.sentTime ?? 0) -
              (current.rCIMIWMessage.sentTime ?? 0) >
          5 * 60 * 1000;
      wrapperTemp = current;
    }
    return msgList;
  }

  ///发送消息滚动
  void scrollWhenMsgSaved(bool isSender) {
    if (extentAfter < 30 || !isSender) {
      Future.delayed(const Duration(milliseconds: 200), () {
        scrollCtrl.jumpTo(scrollCtrl.position.maxScrollExtent);
      });
    }
  }
}
