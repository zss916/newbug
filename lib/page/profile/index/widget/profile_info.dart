import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/generated/assets.dart';

class ProfileInfo extends StatelessWidget {
  final String? avatar;
  final String? name;
  final String? identifier;
  final bool? isVip;
  const ProfileInfo({
    super.key,
    required this.avatar,
    required this.name,
    required this.identifier,
    required this.isVip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w),
      width: double.maxFinite,
      child: Row(
        children: [
          buildAvatar(isVip: isVip ?? false),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    RouteManager.toEditProfile();
                  },
                  child: Row(
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
                ),

                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: "$identifier"));
                    CustomToast.success(T.successful.tr);
                  },
                  child: UnconstrainedBox(
                    child: Container(
                      padding: EdgeInsetsDirectional.all(5.w),
                      child: Row(
                        children: [
                          Text(
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAvatar({required bool isVip}) {
    return Container(
      width: 105,
      height: 110,
      padding: EdgeInsetsDirectional.only(top: 18, end: 1),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            isVip ? Assets.avatarGoldAvatarIc : Assets.avatarSilverAvatarIc,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: UnconstrainedBox(
        child: GestureDetector(
          onTap: () {
            RouteManager.toEditProfile();
          },
          child: Container(
            width: 75,
            height: 75,
            decoration: ShapeDecoration(
              //color: Colors.black26,
              image: (avatar ?? "").isEmpty
                  ? null
                  : DecorationImage(
                      image: CachedNetworkImageProvider(avatar ?? ""),
                      fit: BoxFit.cover,
                    ),
              shape: OvalBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
