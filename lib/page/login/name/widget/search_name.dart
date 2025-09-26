import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';

class SearchName extends StatefulWidget {
  final Function(String) onInput;
  final String? name;

  const SearchName({super.key, required this.onInput, this.name});

  @override
  State<SearchName> createState() => _SearchNameState();
}

class _SearchNameState extends State<SearchName> {
  TextEditingController textEditCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    focusNode.unfocus();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          width: double.maxFinite,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: textEditCtrl,
            focusNode: focusNode,
            onTapOutside: (_) {
              setState(() {
                isEdit = false;
              });
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              fillColor: (focusNode.hasFocus && isEdit)
                  ? Color(0xFFFAE1F0)
                  : Color(0xFFEDEDED),
              filled: true,
              hintText: T.nameHint.tr,
              hintStyle: TextStyle(
                color: const Color(0xFFBFBFBF),
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.black.withValues(alpha: 0.05),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.black.withValues(alpha: 0.05),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFFFF0092)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFFFF0092)),
              ),
            ),
            onChanged: (value) {
              setState(() {
                isEdit = value.trim().isNotEmpty;
              });
              widget.onInput.call(value);
            },
            onEditingComplete: () {
              setState(() {
                isEdit = false;
              });
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onSubmitted: (value) {
              setState(() {
                isEdit = false;
              });
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
        Divider(height: 16.h, color: Colors.transparent),
      ],
    );
  }
}
