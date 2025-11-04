import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/network/model/config_entity.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/services/app_config_service.dart';

void showReportSheet({Function(int reportId)? onItemTap}) {
  List<ConfigReportList> data = AppConfigService.to.reportList;
  Get.bottomSheet(
    ReportCenter(data: data, onItemTap: onItemTap),
    isDismissible: false,
    settings: RouteSettings(name: AppRoutes.reportSheet),
  );
}

class ReportCenter extends StatelessWidget {
  final List<ConfigReportList> data;
  final Function(int reportId)? onItemTap;
  const ReportCenter({super.key, required this.data, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsetsDirectional.only(start: 8.w, end: 8.w),
          decoration: ShapeDecoration(
            color: Color(0xA6000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 16.w,
                  top: 12.h,
                ),
                child: Text(
                  T.report.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFD9D9D9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 16.w,
                  top: 12.h,
                  bottom: 12.h,
                ),
                width: double.maxFinite,
                child: Text(
                  T.reportContent.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFBFBFBF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Divider(height: 1, color: Color(0xFF3B3B3B)),
              SizedBox(
                width: double.maxFinite,
                height: 60.h * data.length,
                child: ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (_, i) =>
                      Divider(height: 1, color: Color(0xFF3B3B3B)),
                  itemBuilder: (_, index) {
                    ConfigReportList item = data[index];
                    return InkWell(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(13),
                        bottomRight: Radius.circular(13),
                      ),
                      onTap: () {
                        Get.back();
                        onItemTap?.call(item.id ?? 4);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60.h,
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          item.title ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          margin: EdgeInsetsDirectional.only(
            top: 8.h,
            start: 8.w,
            end: 8.w,
            bottom: 20.h,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(13),
            onTap: () => Get.back(),
            child: Container(
              alignment: AlignmentDirectional.center,
              width: double.infinity,
              height: 60.h,
              decoration: ShapeDecoration(
                color: Color(0xA6000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Text(
                T.cancel.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF0A84FF),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
