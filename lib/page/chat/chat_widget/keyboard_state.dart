import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';

/// 监听键盘弹出
mixin KeyboardState<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (!mounted) return;
    final currentVisible = keyboardVisible;
    if (_keyboardVisible == currentVisible) return;
    _keyboardVisible = currentVisible;
    onKeyboardChanged(_keyboardVisible);
  }

  double getKeyboardHeight(BuildContext context) {
    final FlutterView view = View.of(context);
    final double bottomInset = EdgeInsets.fromViewPadding(
      view.viewInsets,
      view.devicePixelRatio,
    ).bottom;

    return math.max(bottomInset, 278);
  }

  void onKeyboardChanged(bool visible);

  bool get keyboardVisible {
    final FlutterView view = View.of(context);
    final double bottomInset = EdgeInsets.fromViewPadding(
      view.viewInsets,
      view.devicePixelRatio,
    ).bottom;

    return bottomInset > 100;
  }
}
