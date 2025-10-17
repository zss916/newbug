import 'package:flutter/material.dart';
import 'package:newbug/generated/assets.dart';

class AlbumAdd extends StatelessWidget {
  final Function onAdd;
  const AlbumAdd({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onAdd.call();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        height: double.maxFinite,
        child: UnconstrainedBox(
          child: Image.asset(Assets.imgAlbumAdd, width: 36, height: 36),
        ),
      ),
    );
  }
}
