part of 'index.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String email = '/email';
  static const String sex = '/sex';
  static const String photo = '/photo';
  static const String name = '/name';
  static const String gender = '/gender';
  static const String birth = '/birth';
  static const String interest = '/interest';
  static const String guide = '/guide';
  static const String main = '/main';
  static const String visitor = '/visitor';
  static const String unmatch = '/unmatch';
  static const String notification = '/notification';
  static const String editProfile = '/editProfile';
  static const String deleteAccount = '/deleteAccount';
  static const String privateAlbum = '/privateAlbum';
  static const String subscribe = '/subscribe';
  static const String flashChat = '/flashChat';
  static const String chat = '/chat';
  static const String selectedAlbum = '/selectedAlbum';
  static const String previewView = '/previewView';
  static const String launch = '/launch';
  static const String webview = '/webview';

  static final List<GetPage> routes = [
    GetPage(name: launch, page: () => LaunchView()),
    GetPage(name: home, page: () => HomeView()),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: email, page: () => EmailView()),
    GetPage(name: sex, page: () => SexView()),
    GetPage(name: photo, page: () => PhotoView()),
    GetPage(name: name, page: () => NameView()),
    GetPage(name: gender, page: () => GenderView()),
    GetPage(name: interest, page: () => InterestView()),
    GetPage(name: birth, page: () => BirthView()),
    GetPage(
      name: guide,
      opaque: false,
      transition: Transition.cupertinoDialog,
      page: () => GuideView(),
    ),
    GetPage(
      name: main,
      showCupertinoParallax: false,
      transition: Transition.noTransition,
      page: () => Intro(
        padding: EdgeInsets.zero,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        maskColor: const Color.fromRGBO(0, 0, 0, .6),
        child: const MainView(),
      ),
    ),
    GetPage(name: visitor, page: () => VisitorView()),
    //GetPage(name: unmatch, page: () => UnMatchView()),
    GetPage(name: notification, page: () => NotificationView()),
    GetPage(name: editProfile, page: () => EditView()),
    GetPage(name: deleteAccount, page: () => DeleteAccountView()),
    GetPage(name: privateAlbum, page: () => AlbumView()),
    GetPage(name: subscribe, page: () => SubscribeView()),
    GetPage(name: flashChat, page: () => FlashChatView()),
    GetPage(name: chat, page: () => ChatView()),
    GetPage(name: selectedAlbum, page: () => SelectedAlbumView()),
    GetPage(name: previewView, page: () => PreviewView()),
    GetPage(name: webview, page: () => WebView()),
  ];

  static const String loveDialog = 'loveDialog';

  static const String nextDialog = 'nextDialog';

  static const String helpCenterSheet = 'helpCenterSheet';

  static const String accountSheet = 'accountSheet';

  static const String ghostModeSheet = 'ghostModeSheet';

  static const String paySheet = 'paySheet';

  static const String paySuccessSheet = 'paySuccessSheet';

  static const String payFailedSheet = 'payFailedSheet';

  static const String purchaseFailedSheet = 'purchaseFailedSheet';

  static const String privateAlbumSheet = 'privateAlbumSheet';

  static const String chatMoreSheet = 'chatMoreSheet';

  static const String notificationDialog = 'notificationDialog';

  static const String wildDialog = 'wildDialog';

  static const String blockDialog = 'blockDialog';

  static const String reportSheet = 'reportSheet';
}
