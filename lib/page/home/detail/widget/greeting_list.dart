import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/page/home/detail/widget/auto_loop_scroll_widget.dart';

class GreetingList extends StatelessWidget {
  const GreetingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20.h, bottom: 20.h),
      width: double.maxFinite,
      child: Column(
        children: [
          AutoLoopScrollWidget(
            items: [
              "Hey! What brings you here?",
              "Whassup",
              "You look amazing in your profile picture.",
              "Good morning",
              "Hey! What brings you here?",
              "Whassup",
              "You look amazing in your profile picture.",
              "Good morning",
            ],
            onItemTap: (index) {
              ///
            },
          ),
          Divider(height: 8.h, color: Colors.transparent),
          AutoLoopScrollWidget(
            reverse: true,
            items: [
              "Hey! What brings you here?",
              "Whassup",
              "You look amazing in your profile picture.",
              "Good morning",
              "Hey! What brings you here?",
              "Whassup",
              "You look amazing in your profile picture.",
              "Good morning",
            ],
            onItemTap: (index) {
              ///
            },
          ),
        ],
      ),
    );
  }
}
