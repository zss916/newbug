import 'package:flutter/material.dart';
import 'package:rongcloud_im_kit/rongcloud_im_kit.dart';
import 'package:rongcloud_im_kit/views/chat/bubble/message_callbacks.dart';

class MyCustomMessageBubble extends RCKMessageBubble {
  MyCustomMessageBubble({
    super.key,
    required super.message,
    super.showTime,
    super.alignment,
    super.withoutBubble,
    super.withoutName,
    super.config,
    super.onTap,
    super.onDoubleTap,
    super.onLongPress,
    super.onSwipe,
    super.onAppendBubbleTap,
    super.onAppendBubbleLongPress,
  });

  @override
  Widget buildMessageContent(BuildContext context, String? refName) {
    final bool isMe = message.direction == RCIMIWMessageDirection.send;
    String displayText;
    if (message is RCIMIWTextMessage) {
      displayText = (message as RCIMIWTextMessage).text ?? '';
    } else {
      displayText = '[自定义消息]';
    }

    ///这里实现自定义气泡样式
    return Container(
      color: Colors.amber,
      child: Text(
        displayText,
        style: isMe
            ? (config?.textStyleConfig.senderTextStyle)
            : (config?.textStyleConfig.receiverTextStyle),
      ),
    );
  }

  @override
  Widget? buildAppendBubble(BuildContext context) {
    // 如需在主气泡下追加说明/标签，可在此返回自定义 UI 小面板；不需要则返回 null
    return null;
  }
}

// 将自定义 UI 气泡映射到某个消息类型（示例：原生自定义消息）
final builders = <RCIMIWMessageType, CustomChatItemBubbleBuilder>{
  RCIMIWMessageType.nativeCustom:
      ({
        required message,
        bool? showTime,
        RCKBubbleConfig? config,
        required BuildContext context,
      }) {
        return MyCustomMessageBubble(
          message: message,
          showTime: showTime ?? false,
          config: config,
        );
      },
};
