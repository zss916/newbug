import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/helper/validator_mixin.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/name/widget/search_name.dart';

class InputLayout extends StatefulWidget {
  final String? name;
  final Function(String) onConfirm;

  const InputLayout({super.key, this.name, required this.onConfirm});

  @override
  State<InputLayout> createState() => _InputLayoutState();
}

class _InputLayoutState extends State<InputLayout> with ValidatorMixin {
  bool isEditName = false;
  String name = "";

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      setState(() {
        name = widget.name ?? "";
        isEditName = name.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchName(
          name: name,
          onInput: (isMatch, value) {
            setState(() {
              name = value;
              isEditName = name.trim().isNotEmpty && isMatch;
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
