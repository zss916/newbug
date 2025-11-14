import 'package:flutter/material.dart';

class ChatSendInput extends StatefulWidget {
  final Function(String) onSend;
  const ChatSendInput({super.key, required this.onSend});

  @override
  State<ChatSendInput> createState() => _ChatSendInputState();
}

class _ChatSendInputState extends State<ChatSendInput>
    with WidgetsBindingObserver {
  bool isShowKeyBoard = false;

  TextEditingController textEditingCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    final flutterView = View.of(context);
    final bottomInset = MediaQueryData.fromView(flutterView).viewInsets.bottom;
    if (bottomInset > 0) {
      setState(() {
        isShowKeyBoard = true;
      });
    } else {
      setState(() {
        isShowKeyBoard = false;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    textEditingCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(8),
          ),
          width: double.maxFinite,
          padding: EdgeInsetsDirectional.only(
            start: 0,
            end: 10,
            top: 1,
            bottom: 1,
          ),
          margin: EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
            bottom: 0,
            top: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingCtrl,
                  autofocus: false,
                  style: TextStyle(
                    color: const Color(0xFF323133),
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    prefixIcon: Container(
                      margin: EdgeInsetsDirectional.only(start: 10),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          /*Image.asset(
                            Assets.imageSendPrefix,
                            matchTextDirection: true,
                            width: 28,
                            height: 28,
                          ),*/
                        ],
                      ),
                    ),
                    hintText: "chatSendHint",
                    hintStyle: TextStyle(
                      color: const Color(0xFF91929D),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 12),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  // borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    String content = textEditingCtrl.text.trim();
                    if (content.isNotEmpty) {
                      widget.onSend(content);
                      setState(() {
                        textEditingCtrl.clear();
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.all(10),
                    /*child: Image.asset(
                      Assets.imageChatSend,
                      width: 28,
                      height: 28,
                      matchTextDirection: true,
                    ),*/
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isShowKeyBoard)
          Container(
            width: double.maxFinite,
            padding: EdgeInsetsDirectional.all(16),
            child: Text(
              'Free 3 minutes, then \$4.9 per minute',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF91929D),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        else
          SizedBox(height: 24),
      ],
    );
  }
}
