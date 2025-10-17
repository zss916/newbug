import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/page/profile/album/index/widget/album_add.dart';
import 'package:newbug/page/profile/album/index/widget/album_item.dart';

class BuildBody extends StatefulWidget {
  const BuildBody({super.key});

  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  bool isSelected = true;
  int videoCount = 0;
  int photoCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 20 + 1,
            padding: EdgeInsetsDirectional.only(bottom: 0.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 129 / 172,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return (index == 0)
                  ? AlbumAdd(
                      onAdd: () {
                        ///todo
                      },
                    )
                  : AlbumItem(
                      index: index,
                      onSelected: (value) {
                        ///todo
                      },
                    );
            },
          ),
        ),
        if (isSelected)
          Container(
            color: Colors.white,
            margin: EdgeInsetsDirectional.only(bottom: 10.h),
            padding: EdgeInsetsDirectional.only(
              top: 10.h,
              bottom: 10.h,
              start: 12.w,
              end: 12.w,
            ),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    T.selectAlbumTip.trArgs(["9", "1"]),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        RouteManager.toSelectedAlbum();
                      },
                      child: UnconstrainedBox(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: 21.w,
                            vertical: 8.h,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFF0092),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            T.confirm.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        else
          SizedBox.shrink(),
      ],
    );
  }
}
