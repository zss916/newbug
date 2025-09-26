part of 'index.dart';

class SexView extends StatelessWidget {
  const SexView({super.key});

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
              T.sexTitle.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: CheckList(
              onTap: (isSelect, value) {
                if (isSelect) {
                  showSexDialog(
                    select: value,
                    onConfirm: () {
                      RouteManager.toPhoto();
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
