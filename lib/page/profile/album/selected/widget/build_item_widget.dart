import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/generated/assets.dart';

class BuildItemWidget extends StatefulWidget {
  final bool isVideo;
  final MediaListItem? item;
  final Function? onSelect;
  const BuildItemWidget({
    super.key,
    required this.isVideo,
    this.item,
    this.onSelect,
  });

  @override
  State<BuildItemWidget> createState() => _BuildItemWidgetState();
}

class _BuildItemWidgetState extends State<BuildItemWidget> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = (widget.item?.isChecked == true);
  }

  @override
  void didUpdateWidget(covariant BuildItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item?.id == oldWidget.item?.id) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.item?.isChecked = isChecked;
          widget.onSelect?.call();
        });
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Color(0x1AFF0092),
          image: DecorationImage(
            image: CachedNetworkImageProvider(widget.item?.url ?? ""),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PositionedDirectional(
              top: 6.r,
              end: 6.r,
              child: Image.asset(
                isChecked ? Assets.imgCheckedIcon : Assets.imgUncheckIcon,
                width: 24,
                height: 24,
              ),
            ),
            if (widget.isVideo)
              PositionedDirectional(
                top: 6.r,
                start: 6.r,
                child: Image.asset(
                  Assets.imgIcVideo,
                  width: 32.w,
                  height: 29.h,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BuildItemWidgetPlus extends StatelessWidget {
  final bool isVideo;
  final MediaListItem? item;
  const BuildItemWidgetPlus({super.key, required this.isVideo, this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: Color(0x1AFF0092),
        image: DecorationImage(
          image: CachedNetworkImageProvider(item?.url ?? ""),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PositionedDirectional(
            top: 6.r,
            end: 6.r,
            child: Image.asset(
              item?.isChecked == true
                  ? Assets.imgCheckedIcon
                  : Assets.imgUncheckIcon,
              width: 24,
              height: 24,
            ),
          ),
          if (isVideo)
            PositionedDirectional(
              top: 6.r,
              start: 6.r,
              child: Image.asset(Assets.imgIcVideo, width: 32.w, height: 29.h),
            ),
        ],
      ),
    );
  }
}
