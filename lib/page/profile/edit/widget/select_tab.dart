import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/page/profile/edit/widget/select_tab_bar.dart';

class SelectTab extends StatefulWidget {
  final Function(int index) onTabSelected;
  const SelectTab({super.key, required this.onTabSelected});

  @override
  State<SelectTab> createState() => _SelectTabState();
}

class _SelectTabState extends State<SelectTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            setState(() {
              _selectedIndex = 0;
              widget.onTabSelected(_selectedIndex);
            });
          },
          child: SelectTabBar(
            title: T.public.tr,
            isSelected: _selectedIndex == 0,
          ),
        ),
        VerticalDivider(width: 10, color: Colors.transparent),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            setState(() {
              _selectedIndex = 1;
              widget.onTabSelected(_selectedIndex);
            });
          },
          child: SelectTabBar(
            title: T.private.tr,
            isSelected: _selectedIndex == 1,
          ),
        ),
      ],
    );
  }
}
