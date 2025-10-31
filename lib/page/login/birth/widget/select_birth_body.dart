import 'package:awesome_datetime_picker/awesome_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/helper/date_helper.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/birth/index.dart';

class SelectBirthBody extends StatefulWidget {
  final BirthLogic logic;
  final DateTime? birthDateTimr;
  const SelectBirthBody({super.key, required this.logic, this.birthDateTimr});

  @override
  State<SelectBirthBody> createState() => _SelectBirthBodyState();
}

class _SelectBirthBodyState extends State<SelectBirthBody> {
  DateTime birth = (DateTime(
    DateTime.now().year - 18,
    DateTime.now().month,
    DateTime.now().day,
  ));

  @override
  void initState() {
    super.initState();
    if (widget.birthDateTimr != null) {
      setState(() {
        birth =
            widget.birthDateTimr ??
            (DateTime(
              DateTime.now().year - 18,
              DateTime.now().month,
              DateTime.now().day,
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(
            top: 30.h,
            start: 18.w,
            end: 18.w,
            bottom: 20.h,
          ),
          width: Get.width,
          child: Text(
            T.birthTitle.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(top: 0, start: 20.w, end: 20.w),
          width: double.maxFinite,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 35,
                width: double.maxFinite,
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0x19FF0092),
                  border: Border.all(width: 1, color: Color(0xFFFF54E8)),
                  borderRadius: BorderRadiusDirectional.circular(7),
                ),
              ),
              AwesomeDatePicker(
                initialDate: AwesomeDate(
                  year: birth.year,
                  month: birth.month,
                  day: birth.day,
                ),
                maxDate: AwesomeDate(
                  year: DateTime.now().year,
                  month: DateTime.now().month,
                  day: DateTime.now().day,
                ),
                minDate: AwesomeDate(
                  year: (DateTime.now().year - 70),
                  month: DateTime.now().month,
                  day: DateTime.now().month,
                ),
                dateFormat: AwesomeDateFormat.yMd,
                backgroundColor: Colors.transparent,
                fadeEffect: false,
                itemHeight: 40,
                unselectedTextStyle: TextStyle(
                  fontSize: 18.sp,
                  color: const Color(0xFF525252),
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
                selectorColor: Colors.transparent,
                onChanged: (AwesomeDate date) {
                  setState(() {
                    birth = DateTime(date.year, date.month, date.day);
                  });
                },
              ),
            ],
          ),
        ),
        Spacer(),
        Container(
          alignment: AlignmentDirectional.center,
          width: double.maxFinite,
          child: Text(
            T.age.trArgs(["${birth.calculateAge}"]),
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(
            bottom: 60.h,
            start: 24.w,
            end: 24.w,
            top: 10.h,
          ),
          alignment: AlignmentDirectional.center,
          width: double.maxFinite,
          child: Text(
            T.ageTip.tr,
            style: TextStyle(
              color: const Color(0xFF818181),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        CustomBorderButton(
          margin: EdgeInsetsDirectional.only(bottom: 48, start: 24, end: 24),
          border: Border.all(
            width: 1,
            color: (birth.calculateAge >= 18)
                ? Color(0xFFFF0092)
                : Colors.transparent,
          ),
          bgColor: (birth.calculateAge >= 18)
              ? Color(0xFFFF0092)
              : Colors.black.withValues(alpha: 0.30),
          title: T.continueKey.tr,
          textColor: Colors.white,
          onTap: () {
            if (birth.calculateAge >= 18) {
              widget.logic.toEditAge(birthday: birth.dateFormatted);
            }
          },
        ),
      ],
    );
  }
}
