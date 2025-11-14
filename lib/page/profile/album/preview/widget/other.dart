import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newbug/core/widget/generated/assets.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => Get.back(),
          child: UnconstrainedBox(
            child: Image.asset(
              Assets.imgToBack,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: SizedBox.shrink(),
    );
  }
}
