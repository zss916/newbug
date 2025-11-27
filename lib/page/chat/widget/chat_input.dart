import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/album/gallery/gallery_tools.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/chat/chat_widget/keyboard_state.dart';
import 'package:newbug/page/chat/index.dart';
import 'package:newbug/page/chat/sheet/showPrivateAlbum.dart';
import 'package:newbug/page/chat/widget/chat_pick_image.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class InputSend extends StatefulWidget {
  final Function(String) onSend;
  final Function(bool)? onKeyboardChanged;
  final Function(List<AssetEntity>)? onSelectPublicAlbum;
  final Function(List<AssetEntity>)? onSelectPublicAlbumToPrivate;
  final ChatType? chatType;

  const InputSend({
    super.key,
    required this.onSend,
    this.onKeyboardChanged,
    this.onSelectPublicAlbum,
    this.onSelectPublicAlbumToPrivate,
    this.chatType,
  });

  @override
  _InputSendState createState() => _InputSendState();
}

class _InputSendState extends State<InputSend>
    with WidgetsBindingObserver, KeyboardState {
  final TextEditingController textEditCtrl = TextEditingController();

  bool isCanSend = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditCtrl.dispose();
    super.dispose();
  }

  @override
  void onKeyboardChanged(bool visible) {
    if (visible) {
      widget.onKeyboardChanged?.call(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 14.w,
        end: 14.w,
        top: 12.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          if (widget.chatType == ChatType.customerService)
            commonImagePick(context)
          else
            ChatPickImage(
              onPublicAlbum: () {
                ///todo 是否可以发送私有图片
                if (true) {
                  openCustomAlbum(context);
                } else {
                  openPublicAlbum(context);
                }
              },
              onPrivateAlbum: () {
                showPrivateAlbum(
                  onConfirm: () {
                    RouteManager.toPrivateAlbum(
                      add: true,
                      select: true,
                      send: true,
                    );
                  },
                );
              },
            ),
          Expanded(
            child: Container(
              margin: EdgeInsetsDirectional.only(start: 8.w),
              padding: EdgeInsetsDirectional.only(start: 14.w, end: 9.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xFFFFEEF7),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditCtrl,
                      onChanged: (value) {
                        setState(() {
                          isCanSend = value.isNotEmpty;
                        });
                      },
                      autofocus: false,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: T.inputHint.tr,
                        hintStyle: TextStyle(
                          color: const Color(0xFFA9A9A9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        String content = textEditCtrl.text.trim();
                        if (content.isNotEmpty) {
                          widget.onSend(content);
                          setState(() {
                            textEditCtrl.clear();
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsetsDirectional.all(0),
                        child: Image.asset(
                          isCanSend ? Assets.imgSendTo : Assets.imgSend,
                          width: 28,
                          height: 28,
                          matchTextDirection: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///打开公共相册
  Future<void> openPublicAlbum(BuildContext context) async {
    GalleryTools.openGallery(
      context: context,
      maxAssets: 1,
      type: RequestType.common,
    ).then((List<AssetEntity> assets) {
      if (assets.isNotEmpty) {
        widget.onSelectPublicAlbum?.call(assets);
      }
    });
  }

  Future<void> openCustomAlbum(BuildContext context) async {
    GalleryTools.openCustomAlbum(
      context,
      onSelect: (bool isSendAsPrivate, List<AssetEntity> result) {
        if (isSendAsPrivate) {
          widget.onSelectPublicAlbumToPrivate?.call(result);
        } else {
          if (result.isNotEmpty) {
            widget.onSelectPublicAlbum?.call(result);
          }
        }
      },
    );
  }

  ///默认手机相册
  Widget commonImagePick(BuildContext context) {
    return InkWell(
      onTap: () {
        openPublicAlbum(context);
      },
      child: Image.asset(Assets.imgChatAlbum, width: 40, height: 40),
    );
  }
}
