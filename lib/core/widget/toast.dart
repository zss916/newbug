part of 'index.dart';

abstract class CustomToast {
  static TransitionBuilder init({
    required BuildContext context,
    required ThemeData theme,
    required TransitionBuilder builder,
  }) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..radius = 10
      ..boxShadow = [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          offset: Offset.zero,
          blurRadius: 15,
        ),
      ]
      ..progressColor = Colors.transparent
      ..contentPadding = const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      )
      ..backgroundColor = theme.colorScheme.surfaceContainer
      ..maskColor = Colors.transparent
      ..indicatorColor = Colors.white
      ..textColor = theme.colorScheme.primaryFixed
      ..textStyle = TextStyle(
        fontSize: 14,
        color: theme.colorScheme.primaryFixed,
      )
      ..maskType = EasyLoadingMaskType.clear
      ..userInteractions = true
      ..dismissOnTap = false
      ..indicatorWidget = const CustomLoadingIndicator();
    return EasyLoading.init(builder: builder);
  }

  static void text(
    String text, {
    EasyLoadingToastPosition position = EasyLoadingToastPosition.center,
  }) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.clear
      ..userInteractions = true;
    EasyLoading.showToast(text, toastPosition: position);
  }

  static void success(String text) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.clear
      ..userInteractions = true;
    EasyLoading.showSuccess(text);
  }

  static void fail(String text) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.clear
      ..userInteractions = true;
    EasyLoading.showError(text);
  }

  static void loading([String? text]) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.custom
      ..userInteractions = false;
    EasyLoading.show(status: text);
  }

  static void dismiss() => EasyLoading.dismiss();
}

class CustomLoadingIndicator extends StatefulWidget {
  final Color? color;
  final double size;
  final double strokeWidth;
  final Duration duration;
  final EdgeInsetsGeometry? padding;
  final AnimationController? controller;

  const CustomLoadingIndicator({
    super.key,
    this.color,
    this.strokeWidth = 4.0,
    this.size = 40.0,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
    this.padding,
  });

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    _controller =
        (widget.controller ??
              AnimationController(vsync: this, duration: widget.duration))
          ..addListener(() => setState(() {}))
          ..repeat();
    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );
    _animation2 = Tween(begin: -2 / 3, end: 1 / 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.linear),
      ),
    );
    _animation3 = Tween(begin: 0.25, end: 5 / 6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: _RingCurve()),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(10),
      child: Transform(
        transform: Matrix4.identity()
          ..rotateZ((_animation1.value) * 5 * pi / 6),
        alignment: FractionalOffset.center,
        child: SizedBox.fromSize(
          size: Size.square(widget.size),
          child: CustomPaint(
            painter: _RingPainter(
              paintWidth: widget.strokeWidth,
              trackColor: widget.color ?? App.primaryColor,
              progressPercent: _animation3.value,
              startAngle: pi * _animation2.value,
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.paintWidth,
    this.progressPercent,
    this.startAngle,
    required this.trackColor,
  }) : trackPaint = Paint()
         ..style = PaintingStyle.stroke
         ..strokeWidth = paintWidth
         ..strokeCap = StrokeCap.round;

  final double paintWidth;
  final Paint trackPaint;
  final Color trackColor;
  final double? progressPercent;
  final double? startAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - paintWidth) / 2;
    trackPaint.color = trackColor.withValues(alpha: 0.2);
    canvas.drawCircle(center, radius, trackPaint);
    trackPaint.color = trackColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle!,
      2 * pi * progressPercent!,
      false,
      trackPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _RingCurve extends Curve {
  const _RingCurve();

  @override
  double transform(double t) => (t <= 0.5) ? 2 * t : 2 * (1 - t);
}
