import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyChainTool {
  static final FlutterSecureStorage _keyStorage = FlutterSecureStorage();

  static final String chainKey = "cv-key-account-and-password";

  static final String accountKey = "account";

  static final String passwordKey = "password";

  /// 保存账号密码
  static Future<void> putKeyChain({
    required String account,
    required String password,
  }) async {
    await _keyStorage.write(
      key: chainKey,
      value: jsonEncode({accountKey: account, passwordKey: password}),
      iOptions: const IOSOptions(
        accessibility: KeychainAccessibility.unlocked_this_device,
      ),
    );
  }

  /// 获取账号密码
  static Future<(String account, String password)> getKeyChain() async {
    final value = await _keyStorage.read(key: chainKey);
    if (value != null) {
      Map<String, dynamic> map = jsonDecode(value);
      return (map[accountKey] as String, map[passwordKey] as String);
    } else {
      return ("", "");
    }
  }
}
