import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class CameraTools {
  /// 打开相机
  static Future<AssetEntity?> openCamera() async {
    FocusManager.instance.primaryFocus?.unfocus();
    return await CameraPicker.pickFromCamera(
      Get.context!,
      pickerConfig: const CameraPickerConfig(
        permissionRequestOption: PermissionRequestOption(),
      ),
    );
  }
}
