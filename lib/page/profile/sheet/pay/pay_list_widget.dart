import 'package:flutter/material.dart';
import 'package:newbug/page/profile/sheet/pay/pay_item_widget.dart';

class PayListWidget extends StatefulWidget {
  const PayListWidget({super.key});

  @override
  State<PayListWidget> createState() => _PayListWidgetState();
}

class _PayListWidgetState extends State<PayListWidget> {
  int select = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              select = 0;
            });
          },
          child: PayItemWidget(index: 0, isSelected: select == 0),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            setState(() {
              select = 1;
            });
          },
          child: PayItemWidget(index: 1, isSelected: select == 1),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            setState(() {
              select = 2;
            });
          },
          child: PayItemWidget(index: 2, isSelected: select == 2),
        ),
      ],
    );
  }
}
