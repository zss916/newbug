import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class SwitchMute extends StatefulWidget {
  final Function(bool) onSwitch;
  const SwitchMute({super.key, required this.onSwitch});

  @override
  State<SwitchMute> createState() => _SwitchMuteState();
}

class _SwitchMuteState extends State<SwitchMute> {
  bool isMute = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMute = !isMute;
          widget.onSwitch.call(isMute);
        });
      },
      child: Container(
        padding: EdgeInsetsDirectional.all(10.r),
        child: Image.asset(
          isMute ? Assets.imgMuteClose : Assets.imgMutePlay,
          width: 34.r,
          height: 34.r,
        ),
      ),
    );
  }
}
