import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class AlbumItem extends StatefulWidget {
  final int index;
  final Function(int selectedIndex) onSelected;
  const AlbumItem({super.key, required this.index, required this.onSelected});

  @override
  State<AlbumItem> createState() => _AlbumItemState();
}

class _AlbumItemState extends State<AlbumItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          if (isChecked) {
            widget.onSelected(widget.index);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x1A000000),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
            ),
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        padding: EdgeInsets.all(8.r),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.black.withValues(alpha: 0.50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(end: 3.w),
                        child: Image.asset(
                          Assets.imgIcAlbumVideo,
                          width: 12,
                          height: 12,
                        ),
                      ),
                      Text(
                        '0:24',
                        style: TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 5.w),
                  child: Image.asset(
                    isChecked ? Assets.imgCheckedIcon : Assets.imgUncheckIcon,
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
