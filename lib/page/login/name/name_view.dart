part of 'index.dart';

class NameView extends StatelessWidget {
  const NameView({super.key});

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
              T.nameTitle.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<NameLogic>(
              init: NameLogic(),
              builder: (logic) => InputLayout(
                name: logic.nickName,
                onConfirm: (value) {
                  logic.toEditName(nickName: value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
