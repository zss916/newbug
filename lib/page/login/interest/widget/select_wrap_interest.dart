import 'package:flutter/material.dart';
import 'package:newbug/page/login/interest/widget/interest_tag.dart';

class SelectWrapInterest extends StatelessWidget {
  final List<String> interests;

  const SelectWrapInterest({super.key, required this.interests});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(interests.length, (i) {
        return InterestTag(isSelected: false, title: interests[i]);
      }),
    );
  }
}
