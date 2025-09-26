part of 'index.dart';

/// Custom button with border
class CustomBorderButton extends StatelessWidget {
  final String title;
  final String? icon;
  final Color? bgColor;
  final Color? textColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final Function onTap;
  final SizedBox? iconSize;

  const CustomBorderButton({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
    this.bgColor,
    this.textColor,
    this.margin,
    this.iconSize,
    this.iconColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap.call(),
      child: Container(
        alignment: AlignmentDirectional.center,
        width: double.maxFinite,
        height: 50.h,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
        margin: margin ?? EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
        decoration: BoxDecoration(
          border: border ?? Border.all(width: 1, color: Color(0xFF7D60FF)),
          color: bgColor ?? Colors.transparent,
          borderRadius: BorderRadiusDirectional.all(Radius.circular(50.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Container(
                margin: EdgeInsetsDirectional.only(end: 0.w, bottom: 0),
                child: Image.asset(
                  icon ?? "",
                  color: iconColor,
                  width: iconSize?.width ?? 24,
                  height: iconSize?.height ?? 24,
                  matchTextDirection: true,
                ),
              ),
            Spacer(),
            Container(
              color: Colors.transparent,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? Color(0xFF4F4F4F),
                ),
              ),
            ),
            Spacer(),
            if (icon != null) SizedBox(width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}
