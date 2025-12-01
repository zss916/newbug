import 'package:flutter/material.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:rongcloud_im_kit/rongcloud_im_kit.dart';

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: '会话列表'),
      body: RCKConvoPage(
        config: RCKConvoConfig(
          appBarConfig: RCKConvoAppBarConfig(
            titleConfig: AppbarTitleConfig(text: '会话'),
          ),
          avatarConfig: const RCKAvatarConfig(
            shape: AvatarShape.circle,
            size: 48,
          ),
          titleConfig: const RCKConvoTitleConfig(fontSize: 16, maxLines: 1),
          lastMessageConfig: RCKLastMessageConfig(maxLines: 1),
          timeConfig: RCKTimeConfig(),
          unreadBadgeConfig: RCKUnreadBadgeConfig(
            position: BadgePosition.itemRight,
          ),
          muteIconConfig: RCKMuteIconConfig(show: true),
          itemConfig: const RCKItemConfig(height: 72),
          layoutConfig: const RCKLayoutConfig(horizontalSpacing: 16),
          slidableConfig: RCKSlidableConfig(
            actions: [
              RCKSlidableActionConfig(
                iconPath: RCKThemeProvider().themeIcon.pin ?? '',
                backgroundColor: Colors.black,
                actionType: SlidableActionType.pin,
              ),
              //RCKSlidableActionConfig.pin(),
              RCKSlidableActionConfig.delete(),
            ],
          ),
          listConfig: const RCKListConfig(showSearchBar: false, pageSize: 20),
        ),
        //appBarBuilder: ConvoAppBarBuilder.,
        onItemTap: (context, conversation, index) {
          // 跳转到聊天页面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RCKChatPage(conversation: conversation),
            ),
          );
        },
      ),
    );
  }
}
