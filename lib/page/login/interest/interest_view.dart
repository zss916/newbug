part of 'index.dart';

class InterestView extends StatelessWidget {
  const InterestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        actions: [
          TextButton(
            onPressed: () {
              CustomToast.text("skip");
            },
            child: Text(
              T.skip.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
              T.interestTitle.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            alignment: AlignmentDirectional.center,
            margin: EdgeInsetsDirectional.only(
              top: 16.h,
              start: 12.w,
              end: 12.w,
              bottom: 20.h,
            ),
            child: SelectWrapInterest(
              interests: [
                "ddddddd",
                "dsafdsaf",
                "dsf",
                "dsfdsafdsafsad",
                "sdfdsa",
              ],
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(
              top: 0.h,
              start: 18.w,
              end: 18.w,
              bottom: 10.h,
            ),
            width: Get.width,
            child: Text(
              T.storyTitle.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          EditStory(),
          Spacer(),
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
              //
            },
          ),
        ],
      ),
    );
  }
}
