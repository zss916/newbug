import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/profile/widget/camera_widget.dart';
import 'package:newbug/page/profile/widget/profile_info.dart';
import 'package:newbug/page/profile/widget/profile_items.dart';
import 'package:newbug/page/profile/widget/profile_premium.dart';
import 'package:newbug/page/profile/widget/profile_tab.dart';
import 'package:newbug/page/profile/widget/profile_visitor.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        backgroundColor: Color(0xFFFAFAFA),
        leading: SizedBox.shrink(),
        surfaceTintColor: Colors.white,
        leadingWidth: 0,
        titleWidget: Text(
          T.me.tr,
          style: TextStyle(
            color: const Color(0xFF262626),
            fontSize: 26,
            fontFamily: AppFonts.font1,
          ),
        ),
        centerTitle: false,
        actions: [CameraWidget()],
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileInfo(
              avatar: "xxxxxx",
              name: "Amanda,29",
              identifier: "12345678",
            ),
            ProfileVisitor(visitorsCount: "12"),
            ProfileTab(videosCount: "35", photosCount: "35", chatsCount: "35"),
            ProfilePremium(),
            ProfileItems(),
          ],
        ),
      ),
    );
  }
}
