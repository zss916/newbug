import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/profile/deleteAccount/widget/select_list.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: T.deleteAccount.tr),
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        children: [
          Expanded(
            child: SelectList(
              onSelect: (value) {
                //todo
              },
              onResult: (value) {
                //todo
              },
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 48,
            margin: EdgeInsetsDirectional.only(
              start: 40.w,
              end: 40.w,
              bottom: 24.h,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: ShapeDecoration(
              color: const Color(0xFFFF0092),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(63),
              ),
            ),
            child: Text(
              T.submit.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
