import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/mixin/delayed_init_mixin.dart';
import 'package:newbug/page/login/email/util/key_chain.dart';

class SearchEmail extends StatefulWidget {
  final Function(bool, String) onInput;
  final bool? isShowError;
  final String? email;

  const SearchEmail({
    super.key,
    required this.onInput,
    this.isShowError,
    this.email,
  });

  @override
  State<SearchEmail> createState() => _SearchEmailState();
}

class _SearchEmailState extends State<SearchEmail> with DelayedInitMixin {
  TextEditingController textEditCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isError = false;

  @override
  void initState() {
    super.initState();
    focusNode.unfocus();
    focusNode.addListener(_onFocusChange);
    initData();
  }

  @override
  void afterFirstLayout() {}

  Future<void> initData() async {
    final (String account, String password) = await KeyChainTool.getKeyChain();
    if ((account ?? "").isNotEmpty) {
      setState(() {
        textEditCtrl.text = account ?? "";
        isError = !isValidEmail(account ?? "");
        widget.onInput.call(!isError, account ?? "");
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

  bool isValidEmail(String email) => EmailValidator.validate(email);

  void _onFocusChange() {
    if (!focusNode.hasFocus) {
      _valid();
    }
  }

  void _valid() {
    setState(() {
      String email = textEditCtrl.text.trim();
      isError = !isValidEmail(email);
    });
  }

  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode()); // 隐藏键盘
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibility(
      onChanged: (bool isKeyboardVisible) {
        if (!isKeyboardVisible) {
          if (textEditCtrl.text.isNotEmpty) {
            _valid();
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
            width: double.maxFinite,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [
                AutofillHints.email,
                AutofillHints.username,
                AutofillHints.newUsername,
              ],
              controller: textEditCtrl,
              focusNode: focusNode,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9@._]+")),
              ],
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                fillColor: focusNode.hasFocus
                    ? Color(0xFFFAE1F0)
                    : Color(0xFFEDEDED),
                filled: true,
                hintText: T.emailHint.tr,
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
                if (value.trim().isEmpty) {
                  setState(() {
                    isError = false;
                  });
                } else {
                  setState(() {
                    isError = !isValidEmail(value);
                  });
                }
                widget.onInput.call(!isError, value);
              },
              onEditingComplete: () {
                _hideKeyboard();
                _valid();
              },
              onSubmitted: (value) {
                _hideKeyboard();
                _valid();
              },
            ),
          ),
          if (widget.isShowError == true &&
              isError == true &&
              !focusNode.hasFocus)
            Container(
              margin: EdgeInsetsDirectional.only(
                start: 20.w,
                end: 20.w,
                top: 12.h,
              ),
              width: double.maxFinite,
              child: Text(
                T.emailErrorHint.tr,
                style: TextStyle(
                  color: Color(0xFFF74E57),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Divider(height: 16.h, color: Colors.transparent),
        ],
      ),
    );
  }
}
