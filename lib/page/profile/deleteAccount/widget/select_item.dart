import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/generated/assets.dart';

class SelectItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function onTap;
  const SelectItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsetsDirectional.all(20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 5.w),
              child: Image.asset(
                isSelected ? Assets.imgCheckedIcon : Assets.imgUncheckIcon,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
