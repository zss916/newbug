import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayItemWidget extends StatelessWidget {
  final bool isSelected;

  final int index;

  const PayItemWidget({
    super.key,
    required this.isSelected,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          width: isSelected ? 134.w : 102.w,
          height: isSelected ? 158 : 146,
          margin: EdgeInsetsDirectional.only(top: 16.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: isSelected ? Colors.black : Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? Color(0xFFFFF2F9) : Colors.white,
          ),
          child: Column(
            children: [
              Text(
                '6 times',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isSelected ? 22 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                '\$19.99',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isSelected ? 20 : 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$2.49/time.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFBFBFBF),
                  fontSize: isSelected ? 13 : 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),

              isSelected
                  ? UnconstrainedBox(
                      child: Container(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 14.w,
                          vertical: 5.h,
                        ),
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFFF0092),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'SAVE 37%',
                          style: TextStyle(
                            color: const Color(0xFF000E2E),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            height: 1.18,
                            letterSpacing: 0.06,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      height: 24,
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: const Color(0xFFFF0092),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'SAVE 37%',
                        style: TextStyle(
                          color: const Color(0xFF000E2E),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 1.18,
                          letterSpacing: 0.06,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        if (index == 1)
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: UnconstrainedBox(
              child: Container(
                constraints: BoxConstraints(minWidth: 84),
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.r),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFF0092),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '🌟 ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'POPULAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.18,
                          letterSpacing: -0.30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
