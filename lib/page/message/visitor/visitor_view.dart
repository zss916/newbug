import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/app_blur_widget.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/generated/assets.dart';
import 'package:newbug/page/status/no_visitor_view.dart';

class VisitorView extends StatelessWidget {
  const VisitorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: T.visitor.tr),
      backgroundColor: Color(0xFFFAFAFA),
      body: buildBody(viewState: 2),
    );
  }

  Widget buildBody({required int viewState}) {
    return switch (viewState) {
      _ when viewState == 0 => buildGridList(),
      _ when viewState == 1 => buildEmpty(),
      _ when viewState == 2 => buildLockView(),
      _ => SizedBox.shrink(),
    };
  }

  Widget buildEmpty() => NoVisitorView(bottomPadding: 100.h, onTap: () {});

  Widget buildGridList() => GridView.builder(
    padding: EdgeInsetsDirectional.only(
      start: 14.w,
      end: 14.w,
      top: 14.w,
      bottom: 14.h,
    ),
    shrinkWrap: true,
    itemCount: 20,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 174 / 232,
    ),
    itemBuilder: (context, index) {
      return buildItem();
    },
  );

  Widget buildItem() => Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(
          "https://img1.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
        ),
      ),
      border: Border.all(width: 1, color: Colors.black),
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(26.r),
        topEnd: Radius.circular(26.r),
        bottomStart: Radius.circular(26.r),
        bottomEnd: Radius.circular(72.r),
      ),
    ),
    child: Container(
      padding: EdgeInsetsDirectional.only(
        bottom: 15.h,
        top: 10.h,
        start: 8.w,
        end: 8.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(26.r),
          topEnd: Radius.circular(26.r),
          bottomStart: Radius.circular(26.r),
          bottomEnd: Radius.circular(72.r),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.5, 1],
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.9)],
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 100.w),
                child: Text(
                  'Amanda,29oooooooo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 5.w),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: ShapeDecoration(
                  color: const Color(0xFF262626),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(480.18),
                  ),
                ),
                child: Text(
                  'Online',
                  style: TextStyle(
                    color: const Color(0xFF99FF66),
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            width: double.maxFinite,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Assets.imgLocation, width: 12, height: 12),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 2.w),
                  constraints: BoxConstraints(maxWidth: 60.w),
                  child: Text(
                    'New York',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF7D60FF),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildLockView() => Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      GridView.builder(
        padding: EdgeInsetsDirectional.only(
          start: 14.w,
          end: 14.w,
          top: 14.w,
          bottom: 14.h,
        ),
        shrinkWrap: true,
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 174 / 232,
        ),
        itemBuilder: (context, index) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://img1.baidu.com/it/u=4215474319,2725351576&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
                    ),
                  ),
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(26.r),
                    topEnd: Radius.circular(26.r),
                    bottomStart: Radius.circular(26.r),
                    bottomEnd: Radius.circular(72.r),
                  ),
                ),
                child: AppBlurWidget(
                  isBlur: true,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(26.r),
                    topEnd: Radius.circular(26.r),
                    bottomStart: Radius.circular(26.r),
                    bottomEnd: Radius.circular(72.r),
                  ),
                  sigma: 6,
                  foreground: Container(
                    padding: EdgeInsetsDirectional.only(
                      bottom: 15.h,
                      top: 10.h,
                      start: 8.w,
                      end: 8.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60.w,
                              height: 18.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0x66FFFFFF),
                              ),
                              constraints: BoxConstraints(maxWidth: 100.w),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 5.w),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF262626),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(480.18),
                                ),
                              ),
                              child: Text(
                                'Online',
                                style: TextStyle(
                                  color: const Color(0xFF99FF66),
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: double.maxFinite,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                Assets.imgLocation,
                                width: 12,
                                height: 12,
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(start: 2.w),
                                constraints: BoxConstraints(maxWidth: 60.w),
                                child: Text(
                                  'New York',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: const Color(0xFF7D60FF),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x00000000), Color(0xA6000000)],
                      ),
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(26.r),
                        topEnd: Radius.circular(26.r),
                        bottomStart: Radius.circular(26.r),
                        bottomEnd: Radius.circular(72.r),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      PositionedDirectional(
        bottom: 0,
        start: 0,
        end: 0,
        child: Container(
          width: double.maxFinite,
          height: 115.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.white54, Colors.white],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.maxFinite,
                height: 48.h,
                margin: EdgeInsetsDirectional.only(
                  start: 24.w,
                  end: 24.w,
                  bottom: 16.h,
                ),
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFF0092),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  'Unlock who visited you',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.31,
                    letterSpacing: -0.32,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
