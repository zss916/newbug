import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/email/widget/search_email.dart';
import 'package:newbug/page/login/email/widget/search_password.dart';

class InputWidget extends StatefulWidget {
  final (String account, String pwd) data;

  final Function(String, String) onConfirm;

  const InputWidget({super.key, required this.onConfirm, required this.data});

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool isEmail = false;
  bool isPsd = false;
  String email = "";
  String psd = "";

  @override
  void initState() {
    super.initState();
    /*setState(() {
      email = widget.data.$1;
      psd = widget.data.$2;
    });*/

    /*em.value = widget.data.$1;
    em.dispose();*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchEmail(
          email: widget.data.$1,
          isShowError: true,
          onInput: (isMatch, value) {
            setState(() {
              email = value;
              isEmail = value.trim().isNotEmpty && isMatch;
            });
          },
        ),

        SearchPassword(
          // pwd: widget.data.$2,
          isShowError: true,
          onInput: (value) {
            setState(() {
              psd = value;
              isPsd = value.trim().isNotEmpty;
            });
          },
        ),
        Spacer(),
        CustomBorderButton(
          margin: EdgeInsetsDirectional.only(bottom: 48, start: 24, end: 24),
          border: Border.all(
            width: 1,
            color: (isEmail && isPsd) ? Color(0xFFFF0092) : Colors.transparent,
          ),
          bgColor: (isEmail && isPsd)
              ? Color(0xFFFF0092)
              : Colors.black.withValues(alpha: 0.30),
          title: T.continueKey.tr,
          textColor: Colors.white,
          onTap: () {
            if (isEmail && isPsd) {
              widget.onConfirm.call(email, psd);
            }
          },
        ),
      ],
    );
  }
}
