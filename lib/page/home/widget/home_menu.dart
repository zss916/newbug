import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/page/dialog/love/dialog_love.dart';
import 'package:newbug/page/dialog/next/dialog_next.dart';
import 'package:newbug/page/home/widget/pie_menu.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  bool isShowPop = false;
  bool isShowMenu = true;
  StreamSubscription<HomeMenuEvent>? subs;

  @override
  void initState() {
    super.initState();
    subs = EventService.to.listen<HomeMenuEvent>((event) {
      setState(() {
        isShowMenu = event.isShow;
      });
    });
    // onInit();
  }

  void onInit() {
    setState(() {
      // isInit = true;
      isShowMenu = true;
      isShowPop = true;
    });
  }

  @override
  void dispose() {
    subs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isShowMenu)
          if (isShowPop)
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: Color(0x33000000),
            ),
        if (isShowMenu)
          PositionedDirectional(
            top:
                Get.statusBarHeight +
                ((Get.width - 28.w - 4) * 483 / 362) -
                70.h -
                35,
            end: 14.w,
            child: PieMenu(
              radius: 80,
              // offset: 0.135,
              offset: 0.3,
              isOpen: false,
              onToggle: (isOpen) {
                setState(() {
                  isShowPop = isOpen;
                });
              },
              onNext: () {
                setState(() {
                  isShowPop = false;
                });
                showNextDialog();
              },
              onChat: () {
                setState(() {
                  isShowPop = false;
                });
              },
              onLike: () {
                setState(() {
                  isShowPop = false;
                });

                showLoveDialog();
              },
            ),
          ),
      ],
    );
  }
}
