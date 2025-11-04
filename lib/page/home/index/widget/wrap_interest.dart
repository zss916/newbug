import 'package:flutter/material.dart';
import 'package:newbug/page/home/index/widget/interest_value_tag.dart';

class WrapInterest extends StatelessWidget {
  final List<String> interests;

  const WrapInterest({super.key, required this.interests});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(interests.length, (i) {
        return InterestValueTag(isSelected: true, title: interests[i]);
      }),
    );
  }
}
