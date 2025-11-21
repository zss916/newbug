import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newbug/core/im/custom_message/custom_message_type.dart';
import 'package:newbug/core/im/custom_message/private_message.dart';
import 'package:newbug/core/im/custom_message/private_package_message.dart';
import 'package:newbug/core/im/custom_message/public_message.dart';
import 'package:newbug/core/im/custom_message/system_message.dart';
import 'package:newbug/core/im/custom_message/system_tips_message.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';

///会话item UI
class ConversationMsgWidget extends StatelessWidget {
  final RCIMIWConversation value;
  const ConversationMsgWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    RCIMIWMessageType? type = value.lastMessage?.messageType;

    return switch (type) {
      ///文字
      _ when type == RCIMIWMessageType.text => buildTextMsg(
        lastMessage: value.lastMessage,
        unreadCount: value.unreadCount,
      ),

      ///图片
      _ when type == RCIMIWMessageType.image => buildImageMsg(
        lastMessage: value.lastMessage,
        unreadCount: value.unreadCount,
      ),

      ///视频
      _ when type == RCIMIWMessageType.sight => buildSightMsg(
        lastMessage: value.lastMessage,
        unreadCount: value.unreadCount,
      ),

      ///撤回消息
      _ when type == RCIMIWMessageType.recall => buildRecallCustomMsg(
        lastMessage: value.lastMessage,
        unreadCount: value.unreadCount,
      ),

      ///用户自定义消息
      _ when type == RCIMIWMessageType.userCustom => buildUserCustomMsg(
        lastMessage: value.lastMessage,
        unreadCount: value.unreadCount,
      ),

      ///未知消息
      _ when type == RCIMIWMessageType.unknown => buildUnknownMsg(
        lastMessage: value.lastMessage,
        unreadCount: value.unreadCount,
      ),

      _ => buildUnknownMsg(
        lastMessage: value.lastMessage,
        unreadCount: value.unreadCount,
      ),
    };
  }

  ///文本消息
  Widget buildTextMsg({RCIMIWMessage? lastMessage, int? unreadCount}) {
    RCIMIWTextMessage msg = lastMessage as RCIMIWTextMessage;
    return Text(
      msg.text ?? "",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: const Color(0xFF494949),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  ///图片消息
  Widget buildImageMsg({RCIMIWMessage? lastMessage, int? unreadCount}) {
    RCIMIWImageMessage msg = lastMessage as RCIMIWImageMessage;
    return Row(
      children: [
        buildMsgStatus(lastMessage),
        Expanded(
          child: Text(
            msg.getConversationDigest(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF494949),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  ///视频消息
  Widget buildSightMsg({RCIMIWMessage? lastMessage, int? unreadCount}) {
    RCIMIWSightMessage msg = lastMessage as RCIMIWSightMessage;
    return Row(
      children: [
        buildMsgStatus(lastMessage),
        Expanded(
          child: Text(
            msg.getConversationDigest(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF494949),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );

    /*return Row(
      children: [
        if (msg.thumbnailBase64String != null)
          Container(
            margin: EdgeInsetsDirectional.only(end: 6.w),
            child: AppBlurWidget(
              isBlur: true,
              sigma: 1.5,
              borderRadius: BorderRadius.circular(6),
              foreground: Image.asset(
                Assets.imgLock,
                width: 14.w,
                height: 14.w,
              ),
              child: Container(
                width: 24,
                height: 20,
                clipBehavior: Clip.hardEdge,
                foregroundDecoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(6),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      msg.thumbnailBase64String ?? "",
                    ),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        Expanded(
          child: Text(
            '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF494949),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox.shrink(),
      ],
    );*/
  }

  ///撤回消息
  Widget buildRecallCustomMsg({RCIMIWMessage? lastMessage, int? unreadCount}) {
    RCIMIWRecallNotificationMessage msg =
        lastMessage as RCIMIWRecallNotificationMessage;
    return Row(
      children: [
        Expanded(
          child: Text(
            "Recall Message",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0x80494949),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox.shrink(),
      ],
    );
  }

  ///未知消息
  Widget buildUnknownMsg({RCIMIWMessage? lastMessage, int? unreadCount}) {
    RCIMIWUnknownMessage msg = lastMessage as RCIMIWUnknownMessage;
    return Text(
      "unknow",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: const Color(0x80494949),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  ///用户自定义消息
  Widget buildUserCustomMsg({RCIMIWMessage? lastMessage, int? unreadCount}) {
    return Row(
      children: [
        buildMsgStatus(lastMessage),
        Expanded(
          child: Text(
            lastMessage?.getConversationDigest() ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF494949),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  ///消息状态
  Widget buildMsgStatus(RCIMIWMessage? lastMsg) {
    RCIMIWSentStatus? msgStatus = lastMsg?.sentStatus;
    var expansionHasFailStatus = _isMsgExpansionOK(lastMsg);
    if (msgStatus == RCIMIWSentStatus.failed || expansionHasFailStatus) {
      return Container(
        padding: EdgeInsets.only(right: 2),
        child: Image.asset(Assets.imgChatError, width: 12, height: 12),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// 判断最新消息的扩展是不是没有发送出去
  bool _isMsgExpansionOK(RCIMIWMessage? lastMsg) {
    bool hasNonZeroCode = false;
    var dataOfExpansion = lastMsg?.expansion?["data"];
    if (dataOfExpansion != null && dataOfExpansion is String) {
      Map<String, dynamic> obj = jsonDecode(dataOfExpansion);
      if (obj["code"] != null) {
        return obj["code"] != 0;
      }
    }
    return hasNonZeroCode;
  }
}

extension MessageDigest on RCIMIWMessage {
  String getConversationDigest() {
    switch (messageType) {
      case RCIMIWMessageType.text:
        return (this as RCIMIWTextMessage).text ?? "";
      case RCIMIWMessageType.image:
        return "[Image]";
      case RCIMIWMessageType.sight:
        return "[Video]";
      case RCIMIWMessageType.userCustom:
        if (this is RCIMIWUserCustomMessage) {
          var object_name = (this as RCIMIWUserCustomMessage).objectName;
          if (object_name != null) {
            if (object_name == CustomMessageType.connected.name) {
              return "";
            } else if (object_name == CustomMessageType.private.name) {
              return (this as PrivateMessage).conversationDigest();
            } else if (object_name == CustomMessageType.public.name) {
              return (this as PublicMessage).conversationDigest();
            } else if (object_name == CustomMessageType.packagePrivate.name) {
              return (this as PrivatePackageMessage).conversationDigest();
            } else if (object_name == CustomMessageType.systemTips.name) {
              return (this as SystemTipsMessage).conversationDigest();
            } else if (object_name == CustomMessageType.system.name) {
              return (this as SystemMessage).conversationDigest();
            } else {
              return "";
            }
          } else {
            return "";
          }
        } else if (this is RCIMIWUnknownMessage) {
          return "";
        }
        return "";
      default:
        return "";
    }
  }
}
