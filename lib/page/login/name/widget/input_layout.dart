import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/name/widget/search_name.dart';

class InputLayout extends StatefulWidget {
  final Function(String) onConfirm;

  const InputLayout({super.key, required this.onConfirm});

  @override
  State<InputLayout> createState() => _InputLayoutState();
}

class _InputLayoutState extends State<InputLayout> {
  bool isEditName = false;
  String name = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchName(
          onInput: (isMatch, value) {
            setState(() {
              isEditName = name.trim().isNotEmpty && isMatch;
              name = value;
            });
          },
        ),
        Spacer(),
        CustomBorderButton(
          margin: EdgeInsetsDirectional.only(
            bottom: 48.h,
            start: 24.w,
            end: 24.w,
          ),
          border: Border.all(
            width: 1,
            color: (isEditName) ? Color(0xFFFF0092) : Colors.transparent,
          ),
          bgColor: (isEditName)
              ? Color(0xFFFF0092)
              : Colors.black.withValues(alpha: 0.30),
          title: T.continueKey.tr,
          textColor: Colors.white,
          onTap: () {
            if (name.isNotEmpty) {
              widget.onConfirm.call(name);
            }
          },
        ),
      ],
    );
  }
}
