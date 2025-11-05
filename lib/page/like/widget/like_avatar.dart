import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newbug/core/network/model/people_entity.dart';

class LikeAvatar extends StatelessWidget {
  final PeopleEntity item;
  const LikeAvatar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(item.headimg ?? ""),
              fit: BoxFit.cover,
            ),
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(50),
          ),
          width: 35,
          height: 35,
        ),
        if (item.isOnline)
          PositionedDirectional(
            top: 0,
            end: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Color(0xFF18CD00),
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
      ],
    );
  }
}
