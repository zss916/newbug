import 'package:flutter/material.dart';

class LikeAvatar extends StatelessWidget {
  const LikeAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://img1.baidu.com/it/u=2407322510,2912386112&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=670",
              ),
              fit: BoxFit.cover,
            ),
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(50),
          ),
          width: 35,
          height: 35,
        ),
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
