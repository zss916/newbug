import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';

class EditStory extends StatefulWidget {
  const EditStory({super.key});

  @override
  State<EditStory> createState() => _EditStoryState();
}

class _EditStoryState extends State<EditStory> {
  String count = "0/200";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsetsDirectional.all(18),
      child: Container(
        width: double.maxFinite,
        height: 128,
        padding: EdgeInsetsDirectional.all(10),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadiusDirectional.circular(16),
        ),
        child: Container(
          color: Colors.transparent,
          width: double.maxFinite,
          height: double.maxFinite,
          child: TextField(
            expands: true,
            maxLines: null,
            inputFormatters: [LengthLimitingTextInputFormatter(200)],
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: TextStyle(
              color: const Color(0xFF6A676C),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: true,
              counterText: count,
              counterStyle: TextStyle(
                color: Colors.black.withValues(alpha: 0.20),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              fillColor: Colors.transparent,
              hintText: T.storyHint.tr,
              hintStyle: TextStyle(
                color: Color(0xFF91929D),
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                count = "${value.trim().length}/200";
              });
            },
          ),
        ),
      ),
    );
  }
}
