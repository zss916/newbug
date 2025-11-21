import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newbug/core/widget/generated/assets.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PrivateAssetPickerBuilder extends DefaultAssetPickerBuilderDelegate {
  void Function(bool value)? sendAsPrivate;
  bool Function()? canSendPrivate;
  final bool showPrivateCheckBox;
  final Future<bool> Function(BuildContext, AssetEntity, bool)?
  customSelectPredicate;

  PrivateAssetPickerBuilder({
    required super.provider,
    required super.initialPermission,
    super.gridCount = 4,
    super.pickerTheme,
    super.textDelegate,
    super.locale,
    // super.keepScrollOffset,
    this.sendAsPrivate,
    this.canSendPrivate,
    this.showPrivateCheckBox = true,
    this.customSelectPredicate,
  }) : super(
         shouldRevertGrid: true,
         specialItemPosition: SpecialItemPosition.none,
         selectPredicate: customSelectPredicate,
       );

  @override
  Future<void> viewAsset(
    BuildContext context,
    int? index,
    AssetEntity currentAsset,
  ) async {
    final DefaultAssetPickerProvider provider = context
        .read<DefaultAssetPickerProvider>();
    if ((!provider.selectedAssets.contains(currentAsset) &&
            provider.selectedMaximumAssets) ||
        (isWeChatMoment &&
            currentAsset.type == AssetType.video &&
            provider.selectedAssets.isNotEmpty)) {
      return;
    }
    final revert = effectiveShouldRevertGrid(context);
    List<AssetEntity> current;
    final List<AssetEntity>? selected;
    final int effectiveIndex;
    current = <AssetEntity>[currentAsset];

    final List<AssetEntity>? result =
        await AssetPickerViewer.pushToViewerWithDelegate(
          context,
          delegate: PrivacyAssetPickerViewerBuilder(
            currentIndex: 0,
            previewAssets: current,
            themeData: theme,
            selectorProvider: provider,
            // provider: provider,
            selectedAssets: provider.selectedAssets,
            maxAssets: provider.maxAssets,
            shouldReversePreview: revert,
            selectPredicate: selectPredicate,
            sendAsPrivate: (bool value) {
              sendAsPrivate?.call(value);
            },
            canSendPrivate: canSendPrivate,
          ),
        );

    if (result != null) {
      Navigator.of(context).maybePop(result);
    }
  }
}

class PrivacyAssetPickerViewerBuilder
    extends DefaultAssetPickerViewerBuilderDelegate {
  bool _sendAsPrivate = false;
  ValueChanged<bool>? sendAsPrivate;
  bool Function()? canSendPrivate;

  PrivacyAssetPickerViewerBuilder({
    required super.currentIndex,
    required super.previewAssets,
    required super.themeData,
    super.selectorProvider,
    super.provider,
    super.selectedAssets,
    super.maxAssets,
    super.shouldReversePreview,
    super.selectPredicate,
    this.sendAsPrivate,
    this.canSendPrivate,
  });

  @override
  Widget bottomDetailBuilder(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        alignment: Alignment.center,
        height: 50 + MediaQuery.paddingOf(context).bottom,
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(top: BorderSide(color: themeData.canvasColor)),
        ),
        child: Row(
          children: [
            SizedBox(width: 28, height: 28),
            Spacer(),
            CustomCheckbox(
              initialValue: false,
              onChanged: (value) {
                sendAsPrivate?.call(value);
              },
            ),
            SizedBox(width: 5.w),
            Text(
              'Send as exclusive',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.of(context).pop([currentAsset]);
              },
              child: Image.asset(Assets.imgSendTo, width: 28, height: 28),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox({Key? key, required this.initialValue, this.onChanged})
    : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckbox,
      child: _isChecked
          ? Image.asset(Assets.imgCheckedIcon, width: 20, height: 20)
          : Image.asset(
              Assets.imgUncheckIcon,
              width: 20,
              height: 20,
              color: Colors.white,
            ),
    );
  }
}
