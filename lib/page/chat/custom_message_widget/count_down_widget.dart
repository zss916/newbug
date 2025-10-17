import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CountDownWidget extends StatelessWidget {
  final int totalDuration;
  final Function? onFinished;
  final double? alpha;
  const CountDownWidget({
    super.key,
    required this.totalDuration,
    this.onFinished,
    this.alpha,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: ShapeDecoration(
        color: Colors.black.withValues(alpha: alpha ?? 0.50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: [
          Image.asset(
            Assets.imgIcFire,
            color: Colors.white,
            width: 14,
            height: 14,
          ),
          Countdown(
            seconds: totalDuration,
            build: (BuildContext context, double time) => Text(
              '${second2HMS(time.toInt()).$1}:${second2HMS(time.toInt()).$2}:${second2HMS(time.toInt()).$3}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                height: 1.18,
                letterSpacing: 0.06,
              ),
            ),
            interval: Duration(seconds: 1),
            onFinished: () {
              debugPrint('Timer is done!');
              onFinished?.call();
            },
          ),
        ],
      ),
    );
  }

  (String h, String m, String s) second2HMS(int sec) {
    String h = "00";
    String m = "00";
    String s = "00";
    if (sec > 0) {
      h = zeroFill(sec ~/ 3600);
      m = zeroFill((sec % 3600) ~/ 60);
      s = zeroFill(sec % 60);
    }
    return (h, m, s);
  }

  String zeroFill(int i) {
    return i >= 10 ? "$i" : "0$i";
  }
}
