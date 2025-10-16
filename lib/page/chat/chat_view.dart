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
      backgroundColor: Color(0xFFE8E6FA),
      body: Column(
        children: [
          ChatAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextMessageWidget(
                    isLocal: false,
                    message: "We go to the same gym, don't we?",
                  ),

                  TextMessageWidget(
                    isLocal: true,
                    message:
                        "think so, yes!l hope you've not seen me there sweating!",
                  ),

                  MediaMessageWidget(
                    isLocal: true,
                    isPrivate: false,
                    imageUrl:
                        "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
                  ),

                  MediaMessageWidget(
                    isLocal: false,
                    isPrivate: true,
                    imageUrl:
                        "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
                  ),

                  MediaMessageWidget(
                    isLocal: false,
                    isDestroyed: true,
                    imageUrl:
                        "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
                  ),

                  SizedBox(height: 200),
                ],
              ),
            ),
          ),
          InputSend(onSend: (value) {}),
        ],
      ),
    );
  }
}
