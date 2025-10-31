import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/page/login/sex/widget/check_widget.dart';

class CheckList extends StatefulWidget {
  final Function(int sex) onTap;
  final int? gender;
  const CheckList({super.key, required this.onTap, this.gender});

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.gender != null) {
      setState(() {
        _selectedIndex = widget.gender ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          child: CheckWidget(title: T.male.tr, isCheck: _selectedIndex == 1),
        ),

        Divider(height: 16.h, color: Colors.transparent),

        GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
          child: CheckWidget(title: T.female.tr, isCheck: _selectedIndex == 2),
        ),

        Divider(height: 16.h, color: Colors.transparent),

        GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 3;
            });
          },
          child: CheckWidget(
            title: T.nonBinary.tr,
            isCheck: _selectedIndex == 3,
          ),
        ),

        Spacer(),

        GestureDetector(
          onTap: () {
            if (_selectedIndex != 0) {
              widget.onTap.call(_selectedIndex);
            }
          },
          child: Container(
            width: double.maxFinite,
            height: 48,
            alignment: AlignmentDirectional.center,
            margin: EdgeInsetsDirectional.only(
              bottom: 48.h,
              start: 24.w,
              end: 24.w,
            ),
            decoration: ShapeDecoration(
              color: _selectedIndex != 0
                  ? const Color(0xFFFF0092)
                  : Colors.black.withValues(alpha: 0.30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            child: Text(
              T.continueKey.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
