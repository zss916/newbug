import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSubscribeItem extends StatefulWidget {
  const BuildSubscribeItem({super.key});

  @override
  _BuildSubscribeItemState createState() => _BuildSubscribeItemState();
}

class _BuildSubscribeItemState extends State<BuildSubscribeItem> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsetsDirectional.only(top: 6.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(index: index);
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 8.h, color: Colors.transparent),
    );
  }

  Widget buildItem({required int index}) => GestureDetector(
    onTap: () {
      setState(() {
        selected = index;
      });
    },
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.maxFinite,
          constraints: BoxConstraints(minHeight: 93.h),
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 20.w,
            vertical: 18.h,
          ),
          margin: EdgeInsetsDirectional.only(
            start: 10.w,
            end: 10.w,
            top: index == 0 ? 12.h : 0.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: selected == index ? Colors.black : Colors.white,
            ),
            color: selected == index ? Color(0xFFFFF2F9) : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3 month',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$59.99',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '\$0.66/day.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black.withValues(
                              alpha: 0.30,
                            ) /* Base-color-Transparency-Black-30 */,
                            fontSize: 12,
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 24,
                margin: EdgeInsetsDirectional.only(start: 10.w),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: const Color(0xFFFF0092) /* Color-1 */,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'SAVE 44%',
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

        if (index == 0)
          PositionedDirectional(
            top: 0,
            start: 30.w,
            child: Container(
              constraints: BoxConstraints(minWidth: 83),
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
      ],
    ),
  );
}
