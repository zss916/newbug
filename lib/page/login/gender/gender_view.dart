part of 'index.dart';

class GenderView extends StatelessWidget {
  const GenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      backgroundColor: Colors.white,
      body: GetBuilder<GenderLogic>(
        init: GenderLogic(),
        builder: (logic) {
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
                  T.genderTitle.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: CheckList(
                  gender: logic.gender,
                  onTap: (sex) {
                    logic.toEditGender(sex: sex);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
