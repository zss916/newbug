import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/page/dialog/love/love_widget.dart';

/// 显示点赞弹窗
void showLoveDialog() {
  Get.dialog(
    DialogLove(),
    barrierDismissible: false,
    routeSettings: RouteSettings(name: AppRoutes.loveDialog),
  );
}

class DialogLove extends StatefulWidget {
  const DialogLove({super.key});

  @override
  State<DialogLove> createState() => _DialogLoveState();
}

class _DialogLoveState extends State<DialogLove> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Get.back();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Stack(
        children: [
          PositionedDirectional(
            top: Get.statusBarHeight + 40.h,
            start: 40.w,
            child: LoveWidget(),
          ),
        ],
      ),
    );
  }
}
