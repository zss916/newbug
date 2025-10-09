import 'package:flutter/cupertino.dart';

class AppSwitchWidget extends StatefulWidget {
  final bool isActive;
  final ValueChanged<bool>? onChanged;
  const AppSwitchWidget({super.key, required this.isActive, this.onChanged});

  @override
  State<AppSwitchWidget> createState() => _AppSwitchWidgetState();
}

class _AppSwitchWidgetState extends State<AppSwitchWidget> {
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isActive = widget.isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _isActive,
      onChanged: (bool value) {
        setState(() => _isActive = value);
        widget.onChanged?.call(_isActive);
      },
      activeTrackColor: CupertinoColors.systemGreen,
    );
  }
}
