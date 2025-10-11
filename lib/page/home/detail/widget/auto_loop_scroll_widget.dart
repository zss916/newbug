import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoLoopScrollWidget extends StatefulWidget {
  final List<String> items;
  final Function(int index) onItemTap;
  final bool? reverse;
  const AutoLoopScrollWidget({
    super.key,
    required this.items,
    required this.onItemTap,
    this.reverse,
  });

  @override
  State<AutoLoopScrollWidget> createState() => _AutoLoopScrollWidgetState();
}

class _AutoLoopScrollWidgetState extends State<AutoLoopScrollWidget> {
  final double scrollSpeed = 0.5;
  Timer? _timer;
  final ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      final double maxScrollExtent = _sc.position.maxScrollExtent;
      final double pixels = _sc.position.pixels;
      if (pixels >= maxScrollExtent) {
        _sc.jumpTo(0.0);
      } else {
        _sc.jumpTo(pixels + scrollSpeed);
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 36,
      child: Listener(
        onPointerDown: (_) {
          _stopTimer();
        },
        onPointerUp: (_) {
          _startTimer();
        },
        child: ListView.separated(
          itemCount: widget.items.length,
          controller: _sc,
          scrollDirection: Axis.horizontal,
          reverse: widget.reverse ?? false,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                widget.onItemTap(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: index % 2 == 0 ? Color(0x19FF0092) : Color(0x1C7D60FF),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Text(
                  widget.items[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: index % 2 == 0
                        ? Color(0xFFFF0092)
                        : Color(0xFF7D60FF),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              VerticalDivider(width: 8.w, color: Colors.transparent),
        ),
      ),
    );
  }
}
