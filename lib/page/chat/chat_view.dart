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
              ChatAppBar(logic: logic),
              FloatCard(),
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

  Widget buildO() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FloatCard(),

            ConnectCardMessageWidget(),

            ///本地打包公开photo
            PackageMessageWidget(
              isLocal: true,
              isVideo: false,
              isPrivate: false,
              images: [
                'https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750',
                'https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670',
                'https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666',
              ],
            ),

            ///远程打包公开photo
            PackageMessageWidget(
              isLocal: false,
              isVideo: false,
              isPrivate: false,
              images: [
                'https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750',
                'https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670',
                'https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666',
              ],
            ),

            ///本地打包公开videos
            PackageMessageWidget(
              isLocal: true,
              isVideo: true,
              isPrivate: false,
              images: [
                'https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750',
                'https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670',
                'https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666',
              ],
            ),

            ///远程打包公开videos
            PackageMessageWidget(
              isLocal: false,
              isVideo: true,
              isPrivate: false,
              images: [
                'https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750',
                'https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670',
                'https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666',
              ],
            ),

            ///远程私密打包图片
            PackageMessageWidget(
              isLocal: true,
              isVideo: false,
              isPrivate: true,
              images: [
                'https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750',
                'https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670',
                'https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666',
              ],
            ),

            ///本地私密打包图片
            PackageMessageWidget(
              isLocal: false,
              //isVideo: true,
              isPrivate: true,
              images: [
                'https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750',
                'https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670',
                'https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666',
              ],
            ),

            ///远程私密打包视频
            PackageMessageWidget(
              isLocal: false,
              isVideo: true,
              isPrivate: true,
              images: [
                'https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750',
                'https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670',
                'https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666',
              ],
            ),

            ///本地私密打包视频
            PackageMessageWidget(
              isLocal: true,
              isVideo: true,
              isPrivate: true,
              images: [
                'https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750',
                'https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670',
                'https://img0.baidu.com/it/u=1882145012,3962079913&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666',
              ],
            ),

            /*TextMessageWidget(
              isLocal: false,
              message: "We go to the same gym, don't we?",
            ),*/

            /*TextMessageWidget(
              isLocal: true,
              message:
                  "think so, yes!l hope you've not seen me there sweating!",
            ),*/

            ///本地单张图片
            /* MediaMessageWidget(
              msgItem: LocalWrapperMsg(),
              onTap: () {
                RouteManager.toPreviewView();
              },
              isLocal: true,
              isPrivate: false,
              imageUrl:
                  "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
            ),*/

            ///远程单张图片
            /*MediaMessageWidget(
              isLocal: false,
              isPrivate: false,
              imageUrl:
                  "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
            ),*/

            ///远程单张私密图片
            /* MediaMessageWidget(
              isLocal: false,
              isPrivate: true,
              isVideo: false,
              imageUrl:
                  "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
            ),*/

            ///本低单张私密图片
            /* MediaMessageWidget(
              isLocal: true,
              isPrivate: true,
              isVideo: false,
              imageUrl:
                  "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
            ),*/

            ///本低单张私密视频
            /*MediaMessageWidget(
              isLocal: true,
              isPrivate: true,
              isVideo: true,
              imageUrl:
                  "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
            ),*/

            ///远程单张私密视频
            /*MediaMessageWidget(
              isLocal: false,
              isPrivate: true,
              isVideo: true,
              imageUrl:
                  "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
            ),*/

            /* MediaMessageWidget(
              isLocal: false,
              isDestroyed: true,
              imageUrl:
                  "https://img0.baidu.com/it/u=895039573,196690770&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750",
            ),*/
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
