import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/widget/chat_pick_image.dart';

class InputSend extends StatefulWidget {
  final Function(String) onSend;
  const InputSend({super.key, required this.onSend});

  @override
  _InputSendState createState() => _InputSendState();
}

class _InputSendState extends State<InputSend> {
  final TextEditingController textEditCtrl = TextEditingController();

  bool isCanSend = false;

  @override
  void dispose() {
    textEditCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 14.w,
        end: 14.w,
        top: 12.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          ChatPickImage(onPublicAlbum: () {}, onPrivateAlbum: () {}),
          Expanded(
            child: Container(
              margin: EdgeInsetsDirectional.only(start: 8.w),
              padding: EdgeInsetsDirectional.only(start: 14.w, end: 9.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xFFFFEEF7),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditCtrl,
                      onChanged: (value) {
                        setState(() {
                          isCanSend = value.isNotEmpty;
                        });
                      },
                      autofocus: false,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: T.inputHint.tr,
                        hintStyle: TextStyle(
                          color: const Color(0xFFA9A9A9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        String content = textEditCtrl.text.trim();
                        if (content.isNotEmpty) {
                          widget.onSend(content);
                          setState(() {
                            textEditCtrl.clear();
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsetsDirectional.all(0),
                        child: Image.asset(
                          isCanSend ? Assets.imgSendTo : Assets.imgSend,
                          width: 28,
                          height: 28,
                          matchTextDirection: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
