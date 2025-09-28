import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class ProfileInfo extends StatelessWidget {
  final String? avatar;
  final String? name;
  final String? identifier;
  const ProfileInfo({
    super.key,
    required this.avatar,
    required this.name,
    required this.identifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w),
      width: double.maxFinite,
      child: Row(
        children: [
          Container(
            width: 105,
            height: 110,
            padding: EdgeInsetsDirectional.only(top: 18, end: 1),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.avatarGoldAvatarIc),
                fit: BoxFit.cover,
              ),
            ),
            child: UnconstrainedBox(
              child: Container(
                width: 75,
                height: 75,
                decoration: ShapeDecoration(
                  //color: Colors.black26,
                  image: DecorationImage(
                    image: NetworkImage(avatar ?? ""),
                    fit: BoxFit.cover,
                  ),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 240.w),
                      padding: EdgeInsetsDirectional.only(
                        start: 5.w,
                        end: 12.w,
                      ),
                      child: Text(
                        name ?? "--",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Image.asset(Assets.imgEdit, width: 27, height: 27),
                  ],
                ),
                Divider(height: 5.h, color: Colors.transparent),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 5.w, end: 5.w),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 240.w),
                        child: Text(
                          'ID:$identifier',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFA8ABB2),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 2.w),
                        child: Image.asset(
                          Assets.imgCopy,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
