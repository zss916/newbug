import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/page/profile/album/selected/selected_album_logic.dart';
import 'package:newbug/page/profile/album/selected/widget/build_item_widget.dart';
import 'package:newbug/page/profile/album/selected/widget/build_top_title.dart';

class BuildPhotosWidgetPlus extends StatefulWidget {
  final List<MediaListItem?> images;
  final SelectedAlbumLogic logic;
  const BuildPhotosWidgetPlus({
    super.key,
    required this.images,
    required this.logic,
  });

  @override
  State<BuildPhotosWidgetPlus> createState() => _BuildPhotosWidgetPlusState();
}

class _BuildPhotosWidgetPlusState extends State<BuildPhotosWidgetPlus> {
  int num = 0;

  @override
  void initState() {
    super.initState();
    num = widget.images.where((e) => e?.isChecked == true).length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildTopTitle(title: T.selectedPhotoTitle.trArgs(["${num}"])),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.w,
            childAspectRatio: 113 / 150,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  widget.images[index]?.isChecked =
                      !(widget.images[index]?.isChecked ?? false);

                  num = widget.images.where((e) => e?.isChecked == true).length;

                  EventService.to.post(
                    SelectPrivateAlbumEvent(media: widget.images[index]),
                  );
                });
              },
              child: BuildItemWidgetPlus(
                item: widget.images[index],
                isVideo: false,
              ),
            );
          },
        ),
      ],
    );
  }
}

/*class BuildPhotosWidget extends StatelessWidget {
  final List<MediaListItem?> images;
  final SelectedAlbumLogic logic;
  const BuildPhotosWidget({
    super.key,
    required this.images,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildTopTitle(title: T.selectedPhotoTitle.trArgs(["${images.length}"])),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.w,
            childAspectRatio: 113 / 150,
          ),
          itemBuilder: (context, index) {
            return BuildItemWidget(
              item: images[index],
              isVideo: false,
              onSelect: () {},
            );
          },
        ),
      ],
    );
  }
}*/
