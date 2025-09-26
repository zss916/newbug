import 'package:flutter/material.dart';

typedef HomeScListenerWidgetBuilder =
    Widget Function(BuildContext context, ScrollController controller);

class HomeScListener extends StatefulWidget {
  final HomeScListenerWidgetBuilder builder;
  final Function(bool isShow) onScrollEnd;
  const HomeScListener({
    super.key,
    required this.builder,
    required this.onScrollEnd,
  });

  @override
  State<HomeScListener> createState() => _HomeScListenerState();
}

class _HomeScListenerState extends State<HomeScListener> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      // 已经滑动到底部
      //debugPrint("滑动到底部2");
      widget.onScrollEnd.call(false);
    } else {
      // 没有滑动到底部
      // debugPrint("滑动${_controller.position.pixels}");
      if (_controller.position.pixels == 0) {
        widget.onScrollEnd.call(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
          // 已经滑动到底部
          // debugPrint("滑动到底部");
        }
        return true; // 返回true以继续传递通知，否则停止传递
      },
      child: widget.builder(context, _controller),
    );
  }
}
