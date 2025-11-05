import 'package:flutter/material.dart';

import 'generated/assets.dart';

class LocationWidget extends StatelessWidget {
  final String address;
  const LocationWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(Assets.imgLocation, width: 20, height: 20),
        Text(
          address,
          style: TextStyle(
            color: const Color(0xFF7D60FF),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
