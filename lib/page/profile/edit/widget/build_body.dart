import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/page/profile/edit/widget/select_tab.dart';

class BuildBody extends StatefulWidget {
  final List<Widget> children;
  const BuildBody({super.key, this.children = const <Widget>[]});

  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsetsDirectional.symmetric(
            horizontal: 14.w,
            vertical: 8.h,
          ),
          width: double.maxFinite,
          child: SelectTab(
            onTabSelected: (index) {
              setState(() {
                controller.jumpToPage(index);
              });
            },
          ),
        ),
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
