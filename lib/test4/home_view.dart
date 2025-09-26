import 'package:flutter/material.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/generated/assets.dart';

class HomeView2 extends StatelessWidget {
  const HomeView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              CustomToast.text("click");
            },
            child: const Text('click text'),
          ),

          TextButton(
            onPressed: () {
              CustomToast.loading("loading");
              Future.delayed(const Duration(seconds: 5), () {
                CustomToast.dismiss();
              });
            },
            child: const Text('click loading'),
          ),

          /*TextButton(
            onPressed: () {
              CustomToast.dismiss();
            },
            child: const Text('click dismiss'),
          ),*/
          TextButton(
            onPressed: () {
              CustomToast.success("success");
            },
            child: const Text('click success'),
          ),

          TextButton(
            onPressed: () {
              CustomToast.fail("fail");
            },
            child: const Text('click fail'),
          ),

          Image.asset(Assets.imgFab, width: 70, height: 70),
        ],
      ),
    );
  }
}
