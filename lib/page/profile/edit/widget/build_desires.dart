import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/page/profile/edit/widget/build_desires_item.dart';

class BuildDesires extends StatefulWidget {
  const BuildDesires({super.key});

  @override
  State<BuildDesires> createState() => _BuildDesiresState();
}

class _BuildDesiresState extends State<BuildDesires> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(
            start: 14.w,
            end: 14.w,
            top: 28.h,
          ),
          width: double.maxFinite,
          child: Text(
            T.desires.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.only(
            start: 14.w,
            top: 10.h,
            end: 14.w,
          ),
          crossAxisCount: 2,
          childAspectRatio: 173 / 152,
          crossAxisSpacing: 9,
          mainAxisSpacing: 12,
          children: [
            BuildDesiresItem(
              title: T.casual.tr,
              subTitle: T.casualContent.tr,
              isSelected: selectedIndex == 0,
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
            ),
            BuildDesiresItem(
              title: T.friendships.tr,
              subTitle: T.friendshipsContent.tr,
              isSelected: selectedIndex == 1,
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
            ),
            BuildDesiresItem(
              title: T.fwb.tr,
              subTitle: T.fwbContent.tr,
              isSelected: selectedIndex == 2,
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
            ),
            BuildDesiresItem(
              title: T.kink.tr,
              subTitle: T.kinkContent.tr,
              isSelected: selectedIndex == 3,
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
              },
            ),
            BuildDesiresItem(
              title: T.texting.tr,
              subTitle: T.textingContent.tr,
              isSelected: selectedIndex == 4,
              onTap: () {
                setState(() {
                  selectedIndex = 4;
                });
              },
            ),
            BuildDesiresItem(
              title: T.watching.tr,
              subTitle: T.watchingContent.tr,
              isSelected: selectedIndex == 5,
              onTap: () {
                setState(() {
                  selectedIndex = 5;
                });
              },
            ),
            BuildDesiresItem(
              title: T.anythingButBoring.tr,
              subTitle: T.anythingButBoringContent.tr,
              isSelected: selectedIndex == 6,
              onTap: () {
                setState(() {
                  selectedIndex = 6;
                  /* if (selectedIndex == 6) {
                    selectedIndex = -1;
                  } else {
                    selectedIndex = 6;
                  }*/
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
