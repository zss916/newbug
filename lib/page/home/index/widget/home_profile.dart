import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';
import 'package:newbug/core/widget/location_widget.dart';
import 'package:newbug/page/location/location_utils.dart';

class HomeProfile extends StatelessWidget {
  final HomeCardsMatchList item;
  const HomeProfile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 14.w, end: 14.w, top: 14.h),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        '${item.nickName ?? ""},${item.age}',
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
                    if (item.isOnline)
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
                          T.online.tr,
                          style: TextStyle(
                            color: const Color(0xFF99FF66),
                            fontSize: 13,
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

          if (LocationUtils.isShowLocationSync(item.location ?? 0))
            LocationWidget(
              address: LocationUtils.getCacheLocationInfo()?.address ?? "",
            ),
        ],
      ),
    );
  }
}
