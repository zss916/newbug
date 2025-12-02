import 'package:flutter/material.dart';
import 'package:newbug/core/kit/kit_chat.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:provider/provider.dart';
import 'package:rongcloud_im_kit/rongcloud_im_kit.dart';

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: '会话列表'),
      body: RCKConvoPage(
        // appBarBuilder: (_, config) => appBarWidget,
        // emptyBuilder: (_) => emptyWidget,
        //avatarBuilder: buildCustomAvatar,
        // titleBuilder: buildCustomTitle,
        // lastMessageBuilder: buildCustomLastMsg,
        // tipBuilder: buildTopTip,
        //itemBuilder: buildCustomItem,
        config: mRCKConvoConfig,
        onItemTap: (context, conversation, index) {
          // 跳转到聊天页面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(conversation: conversation),
            ),
          );
        },
        onItemLongPress: (context, conversation, index) {
          final engineProvider = context.read<RCKEngineProvider>();
          final conversationProvider = context.read<RCKConvoProvider>();

          ///获取总未读数
          ///engineProvider.totalUnreadCount;

          /// 删除会话
          /// conversationProvider.removeConversation(index);

          /// 置顶或取消置顶
          /// conversationProvider.pinConversation(index);
        },
      ),
    );
  }

  ///微调配置
  RCKConvoConfig get mRCKConvoConfig => RCKConvoConfig(
    appBarConfig: RCKConvoAppBarConfig(
      titleConfig: AppbarTitleConfig(text: '会话'),
    ),
    avatarConfig: const RCKAvatarConfig(shape: AvatarShape.circle, size: 48),
    titleConfig: const RCKConvoTitleConfig(fontSize: 16, maxLines: 1),
    lastMessageConfig: RCKLastMessageConfig(maxLines: 1),
    timeConfig: RCKTimeConfig(),
    unreadBadgeConfig: RCKUnreadBadgeConfig(position: BadgePosition.itemRight),
    muteIconConfig: RCKMuteIconConfig(show: true),
    itemConfig: const RCKItemConfig(height: 72),
    layoutConfig: const RCKLayoutConfig(horizontalSpacing: 16),
    slidableConfig: RCKSlidableConfig(
      actions: [
        ///侧滑自定义Ui
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
  );

  ///自定义空状态
  Widget get emptyWidget => Text("无会话列表显示empty");

  ///自定义AppBar
  PreferredSizeWidget get appBarWidget => AppBar(
    title: Text("custom appbar 自定义", style: TextStyle(color: Colors.amber)),
  );

  ///自定义头像
  Widget buildCustomAvatar(
    BuildContext context,
    RCIMIWConversation conversation,
    RCKAvatarConfig config,
  ) {
    return Text("头像自定义");
  }

  ///自定义名称
  Widget buildCustomTitle(
    BuildContext context,
    RCIMIWConversation conversation,
    RCKConvoTitleConfig config,
  ) {
    return Text("姓名自定义");
  }

  ///自定义最后一条消息
  Widget buildCustomLastMsg(
    BuildContext context,
    RCIMIWConversation conversation,
    RCKLastMessageConfig config,
  ) {
    return Text("最后一条消息自定义");
  }

  ///自定义提示
  Widget buildTopTip(BuildContext context) {
    final provider = context.watch<RCKConvoProvider>();
    final isDisconnected =
        provider.connectionStatus != RCIMIWConnectionStatus.connected;

    if (isDisconnected) {
      return Container(
        height: 42,
        color: const Color(0xFFFFF3F3),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off, color: Color(0xFFD32F2F), size: 18),
            SizedBox(width: 6),
            Text('当前网络不可用，请检查网络设置', style: TextStyle(color: Color(0xFF333333))),
          ],
        ),
      );
    }

    // 不需要展示提示时返回占位
    return const SizedBox.shrink();
  }

  ///自定义提示
  Widget buildTopTip2(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.amber.shade50,
      child: Row(
        children: [
          const Icon(Icons.campaign, color: Color(0xFFFF9800), size: 18),
          const SizedBox(width: 6),
          const Expanded(
            child: Text(
              '企业公告：本周五 18:00-20:00 系统维护(顶部公告栏自定义)',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/notice'),
            child: const Text('详情'),
          ),
        ],
      ),
    );
  }

  ///item 完全自定义
  Widget buildCustomItem(
    BuildContext context,
    RCIMIWConversation conversation,
    RCKItemConfig config,
  ) {
    return Text("整个item自定义");
  }
}
