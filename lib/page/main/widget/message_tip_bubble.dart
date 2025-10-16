import 'dart:async';

import 'package:bubble_pop_up/bubble_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/stores/event.dart';

class MessageTipBubble extends StatefulWidget {
  final Widget child;

  const MessageTipBubble({super.key, required this.child});

  @override
  State<MessageTipBubble> createState() => _MessageTipBubbleState();
}

class _MessageTipBubbleState extends State<MessageTipBubble> {
  final popUpKey = GlobalKey<BubblePopUpState>();
  StreamSubscription<ShowMatchCountTipEvent>? subs;

  @override
  void initState() {
    super.initState();
    subs = EventService.to.listen<ShowMatchCountTipEvent>((event) {
      if (event.isShow) {
        popUpKey.currentState?.addPopUpAndSelect();
      } else {
        popUpKey.currentState?.deactivate();
      }
    });
  }

  @override
  void dispose() {
    popUpKey.currentState?.dispose();
    subs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BubblePopUp(
      key: popUpKey,
      onTap: false,
      config: BubblePopUpConfig(arrowCornerRadius: 1),
      popUpColor: Color(0xFFFF0092),
      popUp: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Color(0xFFFF0092),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          T.matchCountTip.trArgs(["99"]),
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ),
      child: widget.child,
    );
  }
}
