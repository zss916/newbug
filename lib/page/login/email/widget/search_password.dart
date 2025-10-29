import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/helper/validator_mixin.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/login/email/util/key_chain.dart';

class SearchPassword extends StatefulWidget {
  final Function(String) onInput;
  final bool? isShowError;
  final String? pwd;

  const SearchPassword({
    super.key,
    required this.onInput,
    this.isShowError,
    this.pwd,
  });

  @override
  State<SearchPassword> createState() => _SearchPasswordState();
}

class _SearchPasswordState extends State<SearchPassword> with ValidatorMixin {
  TextEditingController textEditCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isError = false;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    focusNode.unfocus();
    focusNode.addListener(_onFocusChange);
    initData();
  }

  Future<void> initData() async {
    final (String account, String password) = await KeyChainTool.getKeyChain();
    if (password.isNotEmpty) {
      setState(() {
        textEditCtrl.text = password;
        widget.onInput.call(password);
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

  bool isPsd(String password) => matchPwd(password);

  void _onFocusChange() {
    if (!focusNode.hasFocus) {
      _valid();
    }
  }

  void _valid() {
    setState(() {
      String psd = textEditCtrl.text.trim();
      isError = !isPsd(psd);
    });
  }

  /// 隐藏键盘
  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
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
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              autofillHints: const [
                AutofillHints.password,
                AutofillHints.newPassword,
              ],
              controller: textEditCtrl,
              focusNode: focusNode,
              obscureText: obscureText,
              obscuringCharacter: "*",
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(
                        obscureText ? Assets.imgEyeClose : Assets.imgEyeOpen,
                        width: 30,
                        height: 30,
                        matchTextDirection: true,
                      ),
                    ],
                  ),
                ),
                fillColor: focusNode.hasFocus
                    ? Color(0xFFFAE1F0)
                    : Color(0xFFEDEDED),
                filled: true,
                hintText: T.passwordHint.tr,
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
                    isError = !isPsd(value);
                  });
                }
                if (!isError) {
                  widget.onInput.call(value);
                }
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
          if (widget.isShowError == true && isError == true)
            Container(
              margin: EdgeInsetsDirectional.only(
                start: 20.w,
                end: 20.w,
                top: 12.h,
              ),
              width: double.maxFinite,
              child: Text(
                T.passwordErrorHint.tr,
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
