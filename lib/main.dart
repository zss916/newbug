import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/constants.dart';
import 'package:newbug/core/config/global.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/theme/theme.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      enableLoadingWhenNoData: true,
      enableRefreshVibrate: true,
      enableLoadMoreVibrate: true,
      child: ScreenUtilInit(
        enableScaleText: () => false,
        designSize: Size(402, 874),
        builder: (context, _) => OverlaySupport.global(
          child: GetMaterialApp(
            title: App.name,
            debugShowCheckedModeBanner: true,
            // theme: AppTheme.to.light,
            locale: Get.deviceLocale,
            translations: AppTranslation(),
            fallbackLocale: const Locale("en"),
            getPages: AppRoutes.routes,
            //navigatorObservers: [appRouteObserver],
            builder: CustomToast.init(
              context: context,
              theme: AppTheme.to.light,
              builder: (context, child) => child ?? const Material(),
            ),

            ///解决滑动时高斯模糊闪动问题
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              overscroll: false,
            ),
            defaultTransition: Transition.cupertino,
            // home: MainView(),
            //home: DeleteAccountView(),
            // home: UnMatchView(),
            initialRoute: AppRoutes.launch,
            //home: PhotoView(),
            //home: WrongView(),
          ),
        ),
      ),
    );
  }
}
