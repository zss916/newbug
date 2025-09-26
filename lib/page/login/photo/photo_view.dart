part of 'index.dart';

class PhotoView extends StatelessWidget {
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoLogic>(
      init: PhotoLogic(),
      assignId: true,
      builder: (logic) {
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
                  T.photoTitle.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: logic.list.length,
                padding: EdgeInsetsDirectional.only(
                  start: 24.w,
                  end: 24.w,
                  top: 4.h,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 108 / 143,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) => PhotoCard(
                  isEdit: index % 2 == 0,
                  index: index,
                  onAdd: (index) {
                    ///
                  },
                  onEdit: (index) {
                    ///
                  },
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(
                  start: 24.w,
                  end: 24.w,
                  top: 16.h,
                ),
                width: double.maxFinite,
                child: Text(
                  T.photoAndVideoTitle.tr,
                  style: TextStyle(
                    color: const Color(0xFF818181),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Spacer(),
              CustomBorderButton(
                margin: EdgeInsetsDirectional.only(
                  bottom: 48,
                  start: 24,
                  end: 24,
                ),
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
                  RouteManager.toInterest();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
