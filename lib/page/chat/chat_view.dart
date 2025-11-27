part of 'index.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        leadingWidth: 0,
        surfaceTintColor: Colors.white,
        leading: const SizedBox.shrink(),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFE8E6FA),
      body: GetBuilder<ChatLogic>(
        init: ChatLogic(),
        builder: (logic) {
          return Column(
            children: [
              ChatAppBar(
                userInfo: logic.userInfo,
                chatType: logic.chatType,
                onMoreAction: () {
                  logic.toMoreAction();
                },
              ),
              if (logic.chatType == ChatType.chat) FloatCard(),
              Expanded(
                child: Chat(
                  historyMsg: logic.historyMsg,
                  currentMsg: logic.currentMsg,
                  logic: logic,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
