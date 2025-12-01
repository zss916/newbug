import 'package:flutter/material.dart';
import 'package:rongcloud_im_kit/rongcloud_im_kit.dart';

class ChatScreen extends StatelessWidget {
  // 可以传入完整的会话对象
  //final RCIMIWConversation conversation;

  // ChatScreen({required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RCKChatPage(conversation: RCIMIWConversation.create()),
    );
  }
}
