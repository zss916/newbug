import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/message/visitor/sheet/showGhostModeSheet.dart';
import 'package:newbug/page/message/visitor/visitor_logic.dart';
import 'package:newbug/page/message/visitor/widget/build_visitors_list.dart';
import 'package:newbug/page/status/no_visitor_view.dart';

class VisitorView extends StatelessWidget {
  const VisitorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: T.visitor.tr),
      backgroundColor: Color(0xFFFAFAFA),
      body: GetBuilder<VisitorLogic>(
        init: VisitorLogic(),
        builder: (logic) =>
            buildBody(visitorViewState: logic.visitorViewState, logic: logic),
      ),
    );
  }

  Widget buildBody({
    required int visitorViewState,
    required VisitorLogic logic,
  }) {
    return switch (visitorViewState) {
      _ when visitorViewState == 0 => BuildVisitorsList(logic: logic),
      _ when visitorViewState == 1 => buildEmpty(),
      _ when visitorViewState == 2 => buildLockView(logic: logic),
      _ when visitorViewState == 3 => Center(
        child: CircularProgressIndicator(color: Color(0xFFFF0092)),
      ),
      _ => SizedBox.shrink(),
    };
  }

  Widget buildEmpty() => NoVisitorView(
    bottomPadding: 100.h,
    onTap: () {
      showGhostModeSheet(onSave: () {});
    },
  );

  Widget buildLockView({required VisitorLogic logic}) => Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: BuildVisitorsList(logic: logic),
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
