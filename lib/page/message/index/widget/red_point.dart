import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RedPoint extends StatelessWidget {
  final int count;
  const RedPoint({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (count >= 1 && count <= 99)
          Container(
            width: 15,
            height: 15,
            margin: EdgeInsetsDirectional.only(start: 6.w),
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: FittedBox(
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.60,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        if (count >= 100)
          Container(
            width: 22,
            height: 15,
            margin: EdgeInsetsDirectional.only(start: 6.w),
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: FittedBox(
              child: Text(
                "99+",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.60,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
