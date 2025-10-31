import 'package:flutter/material.dart';
import 'package:newbug/core/network/model/tag_entity.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/interest/widget/tags/tags_widget.dart';

class SelectTagsWidget extends StatefulWidget {
  final List<TagEntity> interests;
  final Function(bool isSelected) onSelected;
  const SelectTagsWidget({
    super.key,
    required this.interests,
    required this.onSelected,
  });

  @override
  State<SelectTagsWidget> createState() => _SelectTagsWidgetState();
}

class _SelectTagsWidgetState extends State<SelectTagsWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(widget.interests.length, (i) {
        return GestureDetector(
          onTap: () {
            if (widget.interests[i].isSelected ?? false) {
              setState(() {
                widget.interests[i].isSelected =
                    !(widget.interests[i].isSelected ?? false);
              });
            } else {
              int selectCount = widget.interests
                  .where((e) => (e.isSelected ?? false))
                  .length;
              if (selectCount >= 8) {
                CustomToast.showText("Select up to 8 Tags.");
              } else {
                setState(() {
                  widget.interests[i].isSelected =
                      !(widget.interests[i].isSelected ?? false);
                });
              }
            }
            int selectCount = widget.interests
                .where((e) => (e.isSelected ?? false))
                .length;
            widget.onSelected.call(selectCount > 0);
          },
          child: TagsWidget(
            isSelected: widget.interests[i].isSelected ?? false,
            title: widget.interests[i].title ?? "",
          ),
        );
      }),
    );
  }
}
