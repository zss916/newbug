import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/interest/index.dart';
import 'package:newbug/page/login/interest/widget/edit_story.dart';
import 'package:newbug/page/login/interest/widget/tags/select_tags_widget.dart';

class InterestBody extends StatefulWidget {
  final InterestLogic logic;
  const InterestBody({super.key, required this.logic});

  @override
  State<InterestBody> createState() => _InterestBodyState();
}

class _InterestBodyState extends State<InterestBody> {
  bool isSelectedTag = false;
  bool isSign = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isSelectedTag = widget.logic.isSelectTag;
      isSign = widget.logic.isSign;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ((widget.logic.type == FormType.editProfile) &&
            (widget.logic.subType == EditType.editInterests))
          Container(
            margin: EdgeInsetsDirectional.only(
              top: 30.h,
              start: 18.w,
              end: 18.w,
              bottom: 20.h,
            ),
            width: Get.width,
            child: Text(
              T.interestTitle.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        if ((widget.logic.type == FormType.editProfile) &&
            (widget.logic.subType == EditType.editInterests))
          Container(
            width: double.maxFinite,
            constraints: BoxConstraints(minHeight: 200.h),
            alignment: AlignmentDirectional.center,
            margin: EdgeInsetsDirectional.only(
              top: 16.h,
              start: 12.w,
              end: 12.w,
              bottom: 20.h,
            ),
            child: buildInterests(widget.logic.viewStatus),
          ),
        if ((widget.logic.type == FormType.editProfile) &&
            (widget.logic.subType == EditType.editSign))
          Container(
            margin: EdgeInsetsDirectional.only(
              top: 0.h,
              start: 18.w,
              end: 18.w,
              bottom: 10.h,
            ),
            width: Get.width,
            child: Text(
              T.storyTitle.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        if ((widget.logic.type == FormType.editProfile) &&
            (widget.logic.subType == EditType.editSign))
          EditStory(
            sign: widget.logic.sign,
            onChanged: (value) {
              widget.logic.sign = value;
              setState(() {
                isSign = value.isNotEmpty;
              });
            },
          ),
        CustomBorderButton(
          margin: EdgeInsetsDirectional.only(bottom: 48, start: 24, end: 24),
          border: Border.all(
            width: 1,
            color: (isSign || isSelectedTag)
                ? Color(0xFFFF0092)
                : Colors.transparent,
          ),
          bgColor: (isSign || isSelectedTag)
              ? Color(0xFFFF0092)
              : Colors.black.withValues(alpha: 0.30),
          title: T.continueKey.tr,
          textColor: Colors.white,
          onTap: () {
            if ((isSign || isSelectedTag)) {
              widget.logic.toContinue();
            }
          },
        ),
      ],
    );
  }

  Widget buildInterests(int viewState) {
    return switch (viewState) {
      _ when viewState == 0 => SelectTagsWidget(
        interests: widget.logic.tags,
        onSelected: (isSelected) {
          setState(() {
            isSelectedTag = isSelected;
          });
        },
      ),
      _ when viewState == 1 => SizedBox(
        width: double.infinity,
        height: 250.h,
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFFFF0092)),
        ),
      ),
      _ when viewState == 2 => SizedBox(width: double.infinity, height: 250.h),
      _ => SizedBox(width: double.infinity, height: 250.h),
    };
  }
}
