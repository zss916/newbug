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

  static final List<GetPage> routes = [
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
      /*page: () => Intro(
        padding: EdgeInsets.zero,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        maskColor: const Color.fromRGBO(0, 0, 0, .6),
        child: const GuideView(),
      ),*/
    ),
    GetPage(
      name: main,
      showCupertinoParallax: false,
      transition: Transition.noTransition,
      //arguments: false,
      // page: () => const MainView(),
      page: () => Intro(
        padding: EdgeInsets.zero,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        maskColor: const Color.fromRGBO(0, 0, 0, .6),
        child: const MainView(),
      ),
    ),
  ];

  static const String loveDialog = 'loveDialog';

  static const String nextDialog = 'nextDialog';

  /*Intro(
  padding: EdgeInsets.zero,
  borderRadius: const BorderRadius.all(Radius.circular(50)),
  maskColor: const Color.fromRGBO(0, 0, 0, .6),
  child: const MainView(),
  )*/
}
