import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:newbug/core/im/custom_message/public_message.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/custom_message_widget/image_message_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/media_message_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/text_message_widget.dart';
import 'package:newbug/page/chat/custom_message_widget/video_message_widget.dart';
import 'package:newbug/page/chat/index.dart';
import 'package:newbug/page/chat/widget/chat_input.dart';
import 'package:newbug/page/profile/album/preview/preview_logic.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class Chat extends StatelessWidget {
  final List<LocalWrapperMsg> historyMsg;
  final List<LocalWrapperMsg> currentMsg;
  final ChatLogic logic;

  final GlobalKey centerKey = GlobalKey();

  Chat({
    super.key,
    required this.historyMsg,
    required this.currentMsg,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => logic.loadHistoryMessage(),
      child: Column(
        children: [
          Expanded(child: buildContent()),
          InputSend(
            onSend: (value) {
              logic.toSend(value: value);
            },
            onKeyboardChanged: (isVisible) {
              logic.scrollWhenMsgSaved(true);
            },
            onSelectPublicAlbum: (List<AssetEntity> value) {
              logic.handPublicAlbum(value);
            },
          ),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Listener(
      onPointerDown: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        SystemChannels.textInput.invokeMethod('TextInput.hide'); //todo
      },
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollNotification) {
            if (notification.metrics is PageMetrics) {
              return false;
            }
            if (notification.metrics is FixedScrollMetrics) {
              if (notification.metrics.axisDirection == AxisDirection.left ||
                  notification.metrics.axisDirection == AxisDirection.right) {
                return false;
              }
            }
            logic.extentAfter = notification.metrics.extentAfter;
            logic.extentBefore = notification.metrics.extentBefore;
          }
          return false;
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          //physics: const AlwaysScrollableScrollPhysics(),
          controller: logic.scrollCtrl,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          center: centerKey,
          slivers: [
            if (historyMsg.isNotEmpty)
              SliverPadding(padding: EdgeInsets.only(top: 16.h)),

            ///历史消息
            if (historyMsg.isNotEmpty)
              SliverList.separated(
                itemCount: logic.historyMsg.length,
                itemBuilder: (BuildContext context, int i) {
                  LocalWrapperMsg historyMsgItem = logic.historyMsg[i];
                  return buildMessageItemWidget(historyMsgItem);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 16.h, color: Colors.transparent);
                },
              ),

            SliverPadding(
              padding: EdgeInsets.only(top: 16.h),
              key: centerKey,
            ),

            ///当前消息
            if (logic.currentMsg.isNotEmpty)
              SliverList.separated(
                itemCount: logic.currentMsg.length,
                itemBuilder: (BuildContext context, int i) {
                  LocalWrapperMsg currentMsgItem = logic.currentMsg[i];
                  return buildMessageItemWidget(currentMsgItem);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 16.h, color: Colors.transparent);
                },
              ),
            SliverPadding(padding: EdgeInsets.only(top: 16.h)),
          ],
        ),
      ),
    );
  }

  Widget buildMessageItemWidget(LocalWrapperMsg msgItem) {
    if (msgItem.rCIMIWMessage.messageType == RCIMIWMessageType.text) {
      return TextMessageWidget(msgItem: msgItem);
    } else if (msgItem.rCIMIWMessage.messageType ==
        RCIMIWMessageType.userCustom) {
      RCIMIWUserCustomMessage customMessage =
          msgItem.rCIMIWMessage as RCIMIWUserCustomMessage;
      return buildCustomMsgItemWidget(customMessage.objectName ?? "", msgItem);
    } else if (msgItem.rCIMIWMessage.messageType == RCIMIWMessageType.image) {
      return buildImageMessage(msgItem);
    } else if (msgItem.rCIMIWMessage.messageType == RCIMIWMessageType.sight) {
      return buildVideoMessage(msgItem);
    } else {
      return Text("未知消息");
    }
  }

  Widget buildCustomMsgItemWidget(String objectName, LocalWrapperMsg msgItem) {
    return switch (objectName) {
      _ when objectName == CustomMessageType.public.name => buildPublicMessage(
        msgItem,
      ),
      _ when objectName == CustomMessageType.private.name =>
        buildPrivateMessage(msgItem),
      _ => SizedBox.shrink(),
    };
  }

  ///公开消息
  Widget buildPublicMessage(LocalWrapperMsg msgItem) {
    return MediaMessageWidget(
      msgItem: msgItem,
      isLocal: msgItem.isSender,
      isPrivate: false,
      onTap: () {
        PublicMessage publicMessage = msgItem.rCIMIWMessage as PublicMessage;
        RouteManager.toPreviewView(
          viewId: PreviewViewType.singlePublicPhoto.index,
          data: {"message": publicMessage},
        );
      },
    );
  }

  ///私有消息
  Widget buildPrivateMessage(LocalWrapperMsg msgItem) {
    return MediaMessageWidget(
      msgItem: msgItem,
      isLocal: msgItem.isSender,
      isPrivate: true,
      onTap: () {
        PrivateMessage privateMessage = msgItem.rCIMIWMessage as PrivateMessage;
        RouteManager.toPreviewView(
          viewId: PreviewViewType.singlePrivatePhoto.index,
          data: {"message": privateMessage},
        );
      },
    );
  }

  ///图片消息(本地发送)
  Widget buildImageMessage(LocalWrapperMsg msgItem) {
    return ImageMessageWidget(
      msgItem: msgItem,
      isLocal: true,
      onTap: () {
        RCIMIWImageMessage imageMessage =
            msgItem.rCIMIWMessage as RCIMIWImageMessage;
        RouteManager.toPreviewView(
          viewId: PreviewViewType.singleImagePhoto.index,
          data: {"message": imageMessage},
        );
      },
    );
  }

  ///视频消息(本地发送)
  Widget buildVideoMessage(LocalWrapperMsg msgItem) {
    return VideoMessageWidget(
      msgItem: msgItem,
      isLocal: true,
      onTap: () {
        RCIMIWSightMessage videoMessage =
            msgItem.rCIMIWMessage as RCIMIWSightMessage;
        RouteManager.toPreviewView(
          viewId: PreviewViewType.singleSightVideo.index,
          data: {"message": videoMessage},
        );
      },
    );
  }
}
