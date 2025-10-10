import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/page/profile/album/widget/album_add.dart';
import 'package:newbug/page/profile/album/widget/album_item.dart';

class BuildBody extends StatefulWidget {
  const BuildBody({super.key});

  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
            ? AlbumAdd(onAdd: () {})
            : AlbumItem(index: index, onSelected: (value) {});
      },
    );
  }
}
