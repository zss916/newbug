import 'package:flutter/material.dart';
import 'package:newbug/core/kit/my_custom_bubble/my_custom_message_bubble.dart';
import 'package:provider/provider.dart';
import 'package:rongcloud_im_kit/rongcloud_im_kit.dart';
import 'package:rongcloud_im_kit/ui_config/chat/page/chat_app_bar_config.dart';
import 'package:rongcloud_im_kit/ui_config/chat/page/chat_background_config.dart';
import 'package:rongcloud_im_kit/views/chat/bubble/message_callbacks.dart';

class ChatScreen extends StatefulWidget {
  final RCIMIWConversation conversation;
  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late RCKEngineProvider _engineProvider;
  late VoidCallback _onReceiveMessage;
  late VoidCallback _onNetworkChange;

  //RCIMIWConnectionStatus

  @override
  void initState() {
    super.initState();
    // 延后到首帧后再读取 context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _engineProvider = context.read<RCKEngineProvider>();

      ///监听收到消息
      _onReceiveMessage = () {
        ///处理额外业务逻辑，避免重复插入消息
        final msg = _engineProvider.receiveMessageNotifier.value;
        if (msg == null) return;
        // 在此处编写自定义逻辑（示例）
        // playSound();  sendLocalAnalytics(msg);  showInAppBanner(msg);
      };
      _engineProvider.receiveMessageNotifier.addListener(_onReceiveMessage);

      ///监听网络连接状态
      _onNetworkChange = () {
        final status = _engineProvider.networkChangeNotifier.value;
      };
      _engineProvider.networkChangeNotifier.addListener(_onNetworkChange);
    });
  }

  @override
  void dispose() {
    // 移除监听，避免内存泄漏
    try {
      _engineProvider.receiveMessageNotifier.removeListener(_onReceiveMessage);
      _engineProvider.networkChangeNotifier.removeListener(_onNetworkChange);
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RCKChatPage(
      config: RCKChatPageConfig().copyWith(
        backgroundConfig: RCKChatBackgroundConfig(),
        inputConfig: RCKMessageInputConfig().copyWith(
          ///todo 角度没改掉(解决:搞下来改源码)
          inputFieldConfig: RCKInputFieldConfig().copyWith(
            borderRadius: 0,
            fillColor: Color(0xFFFFEEF7),
          ),

          ///todo 那边距没改掉
          padding: EdgeInsets.symmetric(horizontal: 50),
          leftButtonConfig: RCKInputButtonConfig().copyWith(
            visible: true,
            icon: InkWell(
              onTap: () {
                debugPrint("click eighteen_mp");
              },
              child: Icon(Icons.eighteen_mp),
            ),
          ),
          rightButtonsConfig: [
            RCKInputButtonConfig().copyWith(
              visible: true,
              icon: Icon(Icons.send),
            ),
          ],
        ),
      ),
      //appBarBuilder: buildCustomAppBar,
      ///todo 吸顶区域没有显示
      stickyHeaderBuilder: buildCustomStickyHeader,

      ///自定义气泡
      //customChatItemBubbleBuilders: customBubble,
      conversation: widget.conversation,
      onMessageTap: onMsgTap,
      onMessageLongPress: onMessageAppendBubbleLongPress,
      onMessageAppendBubbleLongPress: onMessageAppendBubbleLongPress,
    );
  }

  ///点击消息
  void onMsgTap(RCIMIWMessage message, BuildContext context) {}

  ///气泡长按
  bool onMessageAppendBubbleLongPress(
    RCIMIWMessage message,
    BuildContext context,
  ) {
    ///true 默认拦截处理
    return true;
  }

  ///发送文字消息
  Future<void> sendTextMsg() async {
    // 发送文本消息
    final chatProvider = context.read<RCKChatProvider>();
    chatProvider.addTextOrRefrenceMessage("文字消息");
  }

  ///发送图片消息
  Future<void> sendImageMsg() async {
    // 发送图片消息
    final chatProvider = context.read<RCKChatProvider>();
    await chatProvider.addImageMessage(""); // imagePath 是图片的本地路径
  }

  ///发送视频消息
  Future<void> sendVideoMsg() async {
    final chatProvider = context.read<RCKChatProvider>();
    await chatProvider.addSightMessage(
      "", // 视频文件路径
      10, // 视频时长（秒）
    );
  }

  ///完全自定义气泡
  Map<RCIMIWMessageType, CustomChatItemBubbleBuilder> customBubble = {
    RCIMIWMessageType.text:
        ({required message, showTime, config, required context}) {
          return MyCustomMessageBubble(
            message: message,
            showTime: showTime ?? false,
            config: config,

            ///这里可以把默认气泡去掉
            withoutBubble: true,
          );
        },

    RCIMIWMessageType.userCustom:
        ({required message, showTime, config, required context}) {
          return MyCustomMessageBubble(
            message: message,
            showTime: showTime ?? false,
            config: config,

            ///这里可以把默认气泡去掉
            withoutBubble: true,
          );
        },
  };

  ///自定义appbar
  PreferredSizeWidget buildCustomAppBar(
    BuildContext context,
    RCKChatAppBarConfig config,
  ) {
    return AppBar(title: Text("自定义appBar"));
  }

  ///自定义吸顶控件
  Widget buildCustomStickyHeader(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      color: Colors.amberAccent,
      child: Text("吸顶控件"),
    );
  }
}
