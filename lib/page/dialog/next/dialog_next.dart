import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/page/dialog/next/next_widget.dart';

/// 下一页
Future<void> showNextDialog() {
  return Get.dialog(
    DialogNext(),
    barrierDismissible: false,
    routeSettings: RouteSettings(name: AppRoutes.nextDialog),
  );
}

class DialogNext extends StatefulWidget {
  const DialogNext({super.key});

  @override
  State<DialogNext> createState() => _DialogNextState();
}

class _DialogNextState extends State<DialogNext> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
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
            end: 40.w,
            child: NextWidget(),
          ),
        ],
      ),
    );
  }
}
