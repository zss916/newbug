import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/page/like/like_logic.dart';

class TitleTab extends StatefulWidget {
  final Function(int index) onChange;
  final LikeLogic logic;
  const TitleTab({super.key, required this.onChange, required this.logic});

  @override
  State<TitleTab> createState() => _TitleTabState();
}

class _TitleTabState extends State<TitleTab> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(70),
          onTap: () {
            setState(() {
              currentIndex = 0;
              widget.onChange.call(currentIndex);
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              buildTabItem(
                isSelected: currentIndex == 0,
                title: T.whoLikesYou.tr,
              ),
              if (widget.logic.showReadMark)
                PositionedDirectional(
                  top: 1.r,
                  end: 1.r,
                  child: Container(
                    width: 10.r,
                    height: 10.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),

        VerticalDivider(width: 10.w, color: Colors.transparent),

        InkWell(
          borderRadius: BorderRadius.circular(70),
          onTap: () {
            setState(() {
              currentIndex = 1;
              widget.onChange.call(currentIndex);
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              buildTabItem(isSelected: currentIndex == 1, title: T.youLiked.tr),

              PositionedDirectional(
                top: 1.r,
                end: 1.r,
                child: SizedBox(width: 10.r, height: 10.r),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTabItem({required bool isSelected, required String title}) =>
      Container(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: ShapeDecoration(
          color: isSelected ? Color(0xFFFF0092) : Color(0x0C7D60FF),
          shape: RoundedRectangleBorder(
            side: isSelected
                ? BorderSide.none
                : BorderSide(width: 1, color: Color(0xFF7D60FF)),
            borderRadius: BorderRadius.circular(70),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
