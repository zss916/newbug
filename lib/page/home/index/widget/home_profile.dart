import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class HomeProfile extends StatelessWidget {
  const HomeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 14.h),
      width: double.maxFinite,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final maxWidth = screenWidth * 0.7;
              return Container(
                margin: EdgeInsetsDirectional.only(bottom: 0.h),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Text(
                        'Amanda,29',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    VerticalDivider(width: 12.w, color: Colors.transparent),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF262626),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: Text(
                        'Online',
                        style: TextStyle(
                          color: const Color(0xFF99FF66),
                          fontSize: 13,
                          fontFamily: 'Golos Text',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              );
            },
          ),

          Row(
            children: [
              Image.asset(Assets.imgLocation, width: 20, height: 20),
              Text(
                'New York',
                style: TextStyle(
                  color: const Color(0xFF7D60FF),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
