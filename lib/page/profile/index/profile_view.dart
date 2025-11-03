import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/profile/index/profile_logic.dart';
import 'package:newbug/page/profile/index/widget/camera_widget.dart';
import 'package:newbug/page/profile/index/widget/profile_info.dart';
import 'package:newbug/page/profile/index/widget/profile_items.dart';
import 'package:newbug/page/profile/index/widget/profile_premium.dart';
import 'package:newbug/page/profile/index/widget/profile_tab.dart';
import 'package:newbug/page/profile/index/widget/profile_visitor.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileLogic>(
      init: ProfileLogic(),
      builder: (logic) {
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
                  avatar: logic.avatar,
                  name: logic.nickName,
                  identifier: logic.uid,
                ),
                ProfileVisitor(visitorsCount: "12"),
                ProfileTab(
                  videosCount: "35",
                  photosCount: "35",
                  chatsCount: "35",
                ),
                ProfilePremium(),
                ProfileItems(logic: logic),
              ],
            ),
          ),
        );
      },
    );
  }
}
