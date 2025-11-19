import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/page/profile/album/selected/selected_album_logic.dart';
import 'package:newbug/page/profile/album/selected/widget/build_item_widget.dart';
import 'package:newbug/page/profile/album/selected/widget/build_top_title.dart';

class BuildVideosWidgetPlus extends StatefulWidget {
  final List<MediaListItem?> videos;
  final SelectedAlbumLogic logic;
  const BuildVideosWidgetPlus({
    super.key,
    required this.videos,
    required this.logic,
  });

  @override
  State<BuildVideosWidgetPlus> createState() => _BuildVideosWidgetPlusState();
}

class _BuildVideosWidgetPlusState extends State<BuildVideosWidgetPlus> {
  int num = 0;

  @override
  void initState() {
    super.initState();
    num = widget.videos.where((e) => e?.isChecked == true).length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildTopTitle(title: T.selectedVideoTitle.trArgs(["${num}"])),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.videos.length,
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
                  widget.videos[index]?.isChecked =
                      !(widget.videos[index]?.isChecked ?? false);

                  num = widget.videos.where((e) => e?.isChecked == true).length;
                  EventService.to.post(
                    SelectPrivateAlbumEvent(media: widget.videos[index]),
                  );
                });
              },
              child: BuildItemWidgetPlus(
                item: widget.videos[index],
                isVideo: true,
              ),
            );
          },
        ),
      ],
    );
  }
}

/*class BuildVideosWidget extends StatelessWidget {
  final List<MediaListItem?> videos;
  final SelectedAlbumLogic logic;
  const BuildVideosWidget({
    super.key,
    required this.videos,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildTopTitle(title: T.selectedVideoTitle.trArgs(["${videos.length}"])),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.w,
            childAspectRatio: 113 / 150,
          ),
          itemBuilder: (context, index) {
            return BuildItemWidget(
              item: videos[index],
              isVideo: true,
              onSelect: () {},
            );
          },
        ),
      ],
    );
  }
}*/
