import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/album/gallery/gallery_tools.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/page/profile/album/index/album_logic.dart';
import 'package:newbug/page/profile/album/index/widget/album_add.dart';
import 'package:newbug/page/profile/album/index/widget/album_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class BuildBody extends StatefulWidget {
  final AlbumLogic logic;
  const BuildBody({super.key, required this.logic});

  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  bool isSelected = true;
  // int videoCount = 0;
  //  int photoCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SmartRefresher(
            enablePullUp: true,
            enablePullDown: false,
            physics: ClampingScrollPhysics(),
            controller: widget.logic.refreshCtrl,
            onLoading: () {
              widget.logic.loadPrivateList();
            },
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: widget.logic.mediaList.length + 1,
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
                        onAdd: () async {
                          List<AssetEntity> list =
                              await GalleryTools.openGallery(
                                context: context,
                                maxAssets: 1,
                                type: RequestType.common,
                              );
                          widget.logic.toAdd(list);
                        },
                      )
                    : AlbumItem(
                        key: Key("${widget.logic.mediaList[index - 1]?.id}"),
                        item: widget.logic.mediaList[index - 1],
                        onSelected: (value) {
                          //todo
                        },
                      );
              },
            ),
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
