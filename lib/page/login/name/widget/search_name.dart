import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/helper/validator_mixin.dart';
import 'package:newbug/core/widget/index.dart';

class SearchName extends StatefulWidget {
  final Function(bool, String) onInput;
  final String? name;

  const SearchName({super.key, required this.onInput, this.name});

  @override
  State<SearchName> createState() => _SearchNameState();
}

class _SearchNameState extends State<SearchName> with ValidatorMixin {
  TextEditingController textEditCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isEdit = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    focusNode.unfocus();
    focusNode.addListener(_onFocusChange);
    textEditCtrl.addListener(() {
      if (textEditCtrl.text.length > 30) {
        CustomToast.showText("Your name can be up to 30 characters.");
      }
      if (textEditCtrl.text.length > 30) {
        textEditCtrl.text = textEditCtrl.text.substring(0, 30);
      }
    });

    if ((widget.name ?? "").isNotEmpty) {
      setState(() {
        textEditCtrl.text = widget.name ?? "";
      });
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    textEditCtrl.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!focusNode.hasFocus) {
      _valid();
    }
  }

  bool isValidate(String input) => matchName(input);

  void _valid() {
    setState(() {
      String text = textEditCtrl.text.trimRight();
      isError = !isValidate(text);
    });
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
            keyboardType: TextInputType.text,
            // maxLength: 30,
            inputFormatters: [
              CapitalizingTextInputFormatter(),
              // LengthLimitingTextInputFormatter(31),
            ],
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
              //errorMaxLines: 1,
              //errorText: isError ? T.nickNameErrorHint.tr : "",
              /*errorStyle: TextStyle(
                color: Color(0xFFF74E57),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),*/
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
              if (value.trimRight().isEmpty) {
                setState(() {
                  isError = false;
                });
              } else {
                setState(() {
                  isError = !isValidate(value.trimRight());
                });
              }

              setState(() {
                isEdit = value.trim().isNotEmpty;
              });
              widget.onInput.call(true, value);
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
        if (isError == true && !focusNode.hasFocus)
          Container(
            margin: EdgeInsetsDirectional.only(
              start: 20.w,
              end: 20.w,
              top: 12.h,
            ),
            width: double.maxFinite,
            child: Text(
              T.nickNameErrorHint.tr,
              style: TextStyle(
                color: Color(0xFFF74E57),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Divider(height: 16.h, color: Colors.transparent),
      ],
    );
  }
}

///首字母大写
class CapitalizingTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String capitalizedText = newValue.text.isEmpty
        ? ''
        : newValue.text[0].toUpperCase() + newValue.text.substring(1);
    return TextEditingValue(
      text: capitalizedText,
      selection: TextSelection.collapsed(offset: capitalizedText.length),
    );
  }
}
