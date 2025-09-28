import 'package:flutter/material.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/widget/index.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        backgroundColor: Color(0xFFFAFAFA),
        leading: SizedBox.shrink(),
        surfaceTintColor: Colors.white,
        leadingWidth: 0,
        titleWidget: Text(
          "Message",
          style: TextStyle(
            color: const Color(0xFF262626),
            fontSize: 26,
            fontFamily: AppFonts.font1,
          ),
        ),
        centerTitle: false,
        actions: [
          ///
        ],
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        children: [
          ///
        ],
      ),
    );
  }
}
