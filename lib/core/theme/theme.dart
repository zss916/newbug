import 'package:flutter/material.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  static AppTheme get to => _instance;

  AppTheme._internal();

  ThemeData get light {
    final scheme = ColorScheme.light(
      ///主题色
      primary: Colors.black,

      ///背景
      surface: Colors.white,

      ///容器
      surfaceContainer: Colors.black,

      ///文字
      primaryFixed: Colors.white,
      secondaryFixed: Colors.white,
      outline: Colors.blue.withValues(alpha: 0.1),
    );
    return _getThemeData(scheme);
  }

  ThemeData _getThemeData(ColorScheme scheme) {
    return ThemeData(
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: NoSplash.splashFactory,
      dividerColor: scheme.outline,
      dividerTheme: DividerThemeData(color: scheme.outline, space: 0.5),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.surface,
        toolbarHeight: 48,
        centerTitle: true,
        titleSpacing: 16,
        foregroundColor: scheme.primaryFixed,
        titleTextStyle: TextStyle(
          fontSize: 19,
          color: scheme.primaryFixed,
          height: 1.3,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(size: 24, color: scheme.primaryFixed),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: 16,
          color: scheme.primaryFixed,
          height: 1.3,
        ),
        titleMedium: TextStyle(
          fontSize: 22,
          color: scheme.primaryFixed,
          height: 1.3,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      buttonTheme: const ButtonThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),
      cardColor: scheme.surfaceContainer,
      tabBarTheme: TabBarThemeData(
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        splashFactory: NoSplash.splashFactory,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        labelColor: scheme.primaryFixed,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelColor: scheme.primaryFixed.withValues(alpha: 0.6),
        unselectedLabelStyle: const TextStyle(fontSize: 16),
      ),
    );
  }
}
