part of 'index.dart';

/// AppBar
AppBar get notTitleAppBar => AppBar(
  backgroundColor: Colors.transparent,
  toolbarHeight: 0,
  leading: const SizedBox.shrink(),
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
  ),
);

/// Home AppBar
AppBar get homeAppBar => AppBar(
  backgroundColor: Colors.transparent,
  toolbarHeight: 0,
  leading: const SizedBox.shrink(),
  systemOverlayStyle: barStyle,
);

/// AppBar
class CommonAppBar extends AppBar {
  CommonAppBar({
    super.key,
    String? title,
    Widget? leading,
    bool? centerTitle,
    super.actions,
    Color? backgroundColor,
    Color? surfaceTintColor,
    super.bottom,
    SystemUiOverlayStyle? systemOverlayStyle,
    Widget? titleWidget,
    bool isTextDark = true,
    Function? back,
    bool? isSetBg,
    final double? leadingWidth,
  }) : super(
         elevation: 0,
         title:
             titleWidget ??
             Text(
               title ?? '',
               maxLines: 1,
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
             ),
         leading:
             leading ??
             UnconstrainedBox(
               child: InkWell(
                 borderRadius: BorderRadius.circular(5),
                 onTap: () {
                   if (back == null) {
                     //Get.back();
                     Navigator.maybePop(Get.context!);
                   } else {
                     back.call();
                   }
                 },
                 child: Container(
                   padding: const EdgeInsetsDirectional.all(5),
                   child: Image.asset(
                     Assets.imgBack,
                     matchTextDirection: true,
                     width: 30,
                     height: 30,
                   ),
                 ),
               ),
             ),
         centerTitle: centerTitle ?? true,
         backgroundColor: backgroundColor ?? Colors.transparent,
         foregroundColor: Colors.transparent,
         surfaceTintColor: surfaceTintColor ?? Colors.transparent,
         systemOverlayStyle: barStyle,
         leadingWidth: leadingWidth,
       );
}

SystemUiOverlayStyle barStyle = const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarDividerColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
);

///base
class BaseAppBar extends AppBar {
  BaseAppBar({
    super.key,
    String? title,
    Color? backgroundColor,
    Widget? titleWidget,
    super.actions,
    super.bottom,
  }) : super(
         backgroundColor: backgroundColor ?? Colors.transparent,
         elevation: 0,
         title:
             titleWidget ??
             Container(
               height: 48,
               width: double.maxFinite,
               color: Colors.transparent,
               child: Row(
                 children: [
                   Container(
                     margin: EdgeInsetsDirectional.only(end: 0),
                     child: InkWell(
                       onTap: () => Get.back(),
                       child: Container(
                         height: 48,
                         padding: EdgeInsetsDirectional.only(end: 14),
                         child: Stack(
                           alignment: AlignmentDirectional.center,
                           children: [
                             Image.asset(
                               Assets.imgToBack,
                               width: 24,
                               height: 24,
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                   Text(
                     title ?? "",
                     style: TextStyle(
                       fontSize: 16.sp,
                       color: Colors.black,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   Spacer(),
                 ],
               ),
             ),
         leading: SizedBox.shrink(),
         leadingWidth: 0,
         centerTitle: false,
         foregroundColor: Colors.transparent,
         surfaceTintColor: Colors.transparent,
         systemOverlayStyle: barStyle,
       );
}
