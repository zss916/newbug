import 'package:flutter/material.dart';
import 'package:newbug/generated/assets.dart';

class PhotoCard extends StatelessWidget {
  final bool isEdit;
  final int index;
  final Function(int)? onAdd;
  final Function(int)? onEdit;
  const PhotoCard({
    super.key,
    required this.isEdit,
    required this.index,
    this.onAdd,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (isEdit)
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              onEdit?.call(index);
            },
            child: Container(
              width: 108,
              height: 143,
              decoration: ShapeDecoration(
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/108x143"),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  PositionedDirectional(
                    top: 6,
                    start: 6,
                    child: Image.asset(
                      Assets.imgVideoIcon,
                      width: 30,
                      height: 20,
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 6,
                    end: 6,
                    child: Image.asset(
                      Assets.imgEditIcon,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              onAdd?.call(index);
            },
            child: Image.asset(Assets.imgPhotoAdd, width: 108, height: 143),
          ),
      ],
    );
  }
}
