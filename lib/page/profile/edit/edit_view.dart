import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/widget/index.dart';

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: T.profile.tr),
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(children: []),
    );
  }
}
