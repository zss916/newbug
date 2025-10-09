import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/page/profile/deleteAccount/widget/select_item.dart';

class SelectList extends StatefulWidget {
  final Function(int index) onSelect;
  final Function(String result) onResult;
  const SelectList({super.key, required this.onSelect, required this.onResult});

  @override
  State<SelectList> createState() => _SelectListState();
}

class _SelectListState extends State<SelectList> {
  int selectIndex = -1;
  int num = 0;
  String result = '';
  // late ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // controller: scrollController,
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 14.w,
              vertical: 16.h,
            ),
            margin: EdgeInsetsDirectional.only(top: 0.h),
            width: double.maxFinite,
            child: Text(
              T.deleteAccountTitle.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(20.r),
            ),
            margin: EdgeInsetsDirectional.symmetric(
              horizontal: 14.w,
              vertical: 8.h,
            ),
            child: Column(
              children: [
                SelectItem(
                  title: T.deleteReason1.tr,
                  isSelected: selectIndex == 0,
                  onTap: () {
                    setState(() {
                      selectIndex = 0;
                      widget.onSelect(selectIndex);
                    });
                  },
                ),
                Divider(height: 1, color: Color(0xFFE1E1E1)),
                SelectItem(
                  title: T.deleteReason2.tr,
                  isSelected: selectIndex == 1,
                  onTap: () {
                    setState(() {
                      selectIndex = 1;
                      widget.onSelect(selectIndex);
                    });
                  },
                ),
                Divider(height: 1, color: Color(0xFFE1E1E1)),
                SelectItem(
                  title: T.deleteReason3.tr,
                  isSelected: selectIndex == 2,
                  onTap: () {
                    setState(() {
                      selectIndex = 2;
                      widget.onSelect(selectIndex);
                    });
                  },
                ),
                Divider(height: 1, color: Color(0xFFE1E1E1)),
                SelectItem(
                  title: T.deleteReason4.tr,
                  isSelected: selectIndex == 3,
                  onTap: () {
                    setState(() {
                      selectIndex = 3;
                      widget.onSelect(selectIndex);
                    });
                  },
                ),
                Divider(height: 1, color: Color(0xFFE1E1E1)),
                SelectItem(
                  title: T.deleteReason5.tr,
                  isSelected: selectIndex == 4,
                  onTap: () {
                    setState(() {
                      selectIndex = 4;
                      widget.onSelect(selectIndex);
                    });
                  },
                ),
                Divider(height: 1, color: Color(0xFFE1E1E1)),
                SelectItem(
                  title: T.deleteReason6.tr,
                  isSelected: selectIndex == 5,
                  onTap: () {
                    setState(() {
                      selectIndex = 5;
                      widget.onSelect(selectIndex);
                    });
                  },
                ),
                Divider(height: 1, color: Color(0xFFE1E1E1)),
                SelectItem(
                  title: T.deleteReason7.tr,
                  isSelected: selectIndex == 6,
                  onTap: () {
                    setState(() {
                      selectIndex = 6;
                      widget.onSelect(selectIndex);
                    });
                  },
                ),
                Divider(height: 1, color: Color(0xFFE1E1E1)),
                SelectItem(
                  title: T.deleteReason8.tr,
                  isSelected: selectIndex == 7,
                  onTap: () {
                    setState(() {
                      selectIndex = 7;
                      widget.onSelect(selectIndex);
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsetsDirectional.only(
              start: 14.w,
              end: 14.w,
              top: 8.h,
              bottom: 40.h,
            ),
            child: Container(
              width: double.maxFinite,
              height: 120,
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                border: Border.all(
                  width: 1,
                  color: Colors.black.withValues(alpha: 0.10),
                ),
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
                    color: const Color(0xFF262626),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: T.pleaseEnter.tr,
                    hintStyle: TextStyle(
                      color: Color(0xFF91929D),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                    border: InputBorder.none,
                    counterText: '$num/200',
                    counterStyle: TextStyle(
                      color: Color(0xFFBFBFBF),
                      fontSize: 13.sp,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      num = value.trim().length;
                      result = value.trim();
                      widget.onResult.call(result);
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
