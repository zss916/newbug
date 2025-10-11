import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class OverlayTools {
  OverlayTools._internal();

  static final OverlayTools _instance = OverlayTools._internal();

  static OverlayTools get instance => _instance;

  OverlaySupportEntry? _currentOverlay;

  final List<WidgetBuilder> _queue = [];

  /// 显示
  void show(WidgetBuilder builder) {
    if (_currentOverlay != null) {
      _queue.add(builder);
    } else {
      _currentOverlay = showOverlayNotification((context) {
        return Material(color: Colors.transparent, child: builder(context));
      }, duration: Duration(seconds: 3));
      _currentOverlay?.dismissed.then((value) {
        _currentOverlay = null;
        if (_queue.isNotEmpty) {
          show(_queue.removeAt(0));
        }
      });
    }
  }

  /// 关闭
  void dismiss() => _currentOverlay?.dismiss();
}
