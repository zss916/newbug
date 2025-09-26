part of 'index.dart';

class BirthView extends StatelessWidget {
  const BirthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      backgroundColor: Colors.white,
      body: Column(
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
                  maxDate: AwesomeDate(
                    year: DateTime.now().year,
                    month: DateTime.now().month,
                    day: DateTime.now().day,
                  ),
                  minDate: AwesomeDate(year: 1910, month: 1, day: 1),
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
                    ///
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
              'Age 26',
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
              'Accurate age = more peers to meet.',
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
              color: true ? Color(0xFFFF0092) : Colors.transparent,
            ),
            bgColor: true
                ? Color(0xFFFF0092)
                : Colors.black.withValues(alpha: 0.30),
            title: T.continueKey.tr,
            textColor: Colors.white,
            onTap: () {
              RouteManager.toGender();
            },
          ),
        ],
      ),
    );
  }
}
