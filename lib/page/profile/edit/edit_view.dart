import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/photo/widget/photo_card.dart';
import 'package:newbug/page/profile/edit/widget/build_body.dart';
import 'package:newbug/page/profile/edit/widget/build_desires.dart';
import 'package:newbug/page/profile/edit/widget/build_interests_item.dart';
import 'package:newbug/page/profile/edit/widget/build_private_album.dart';
import 'package:newbug/page/profile/edit/widget/build_public_item.dart';
import 'package:newbug/page/profile/edit/widget/build_public_item2.dart';

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: T.profile.tr),
      backgroundColor: Color(0xFFFAFAFA),
      body: BuildBody(children: [buildPublic(), buildPrivate()]),
    );
  }

  Widget buildPublic() => SingleChildScrollView(
    child: Column(
      children: [
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          padding: EdgeInsetsDirectional.all(14.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 108 / 143,
            crossAxisSpacing: 9,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) => PhotoCard(
            isEdit: index % 2 == 0,
            index: index,
            onAdd: (index) {
              ///
            },
            onEdit: (index) {
              ///
            },
          ),
        ),
        Container(
          padding: EdgeInsetsDirectional.only(
            start: 14.w,
            end: 14.w,
            bottom: 4,
          ),
          width: double.maxFinite,
          child: Text(
            T.info.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ),
        Divider(height: 12.h, color: Colors.transparent),
        BuildPublicItem(title: T.nickname.tr),
        Divider(height: 12.h, color: Colors.transparent),
        BuildPublicItem(title: T.birthday.tr),
        Divider(height: 12.h, color: Colors.transparent),
        BuildPublicItem(title: T.gender.tr),
        Divider(height: 12.h, color: Colors.transparent),
        BuildPublicItem(title: T.sexualOrientation.tr),
        Divider(height: 12.h, color: Colors.transparent),
        BuildPublicItem2(title: T.aboutMe.tr),
        Divider(height: 30.h, color: Colors.transparent),
        BuildInterestsItem(onTap: () {}),
      ],
    ),
  );

  Widget buildPrivate() => SingleChildScrollView(
    child: Column(
      children: [
        BuildDesires(),
        BuildPrivateAlbum(
          onTap: () {
            RouteManager.toPrivateAlbum();
          },
        ),
      ],
    ),
  );
}
