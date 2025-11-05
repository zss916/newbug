import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/like/like_logic.dart';
import 'package:newbug/page/like/widget/like_body.dart';

class LikeView extends StatelessWidget {
  const LikeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        backgroundColor: Color(0xFFFAFAFA),
        leading: SizedBox.shrink(),
        surfaceTintColor: Colors.white,
        leadingWidth: 0,
        titleWidget: Text(
          T.likes.tr,
          style: TextStyle(
            color: const Color(0xFF262626),
            fontSize: 26,
            fontFamily: AppFonts.font1,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: GetBuilder<LikeLogic>(
        init: LikeLogic(),
        builder: (logic) {
          return LikeBody(logic: logic);
        },
      ),
    );
  }
}
