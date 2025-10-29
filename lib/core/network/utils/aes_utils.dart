import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class AESUtils {
  static final String aesKey = "txd8iWLf5QahuZzH";

  static decode(dynamic data) {
    if (data is String) {
      var encryptedBytes = base64Decode(data.trim());
      var encryptedData = Encrypted(encryptedBytes);
      var decrypted = Encrypter(
        AES(Key.fromUtf8(aesKey), mode: AESMode.cbc),
      ).decrypt(encryptedData, iv: IV.fromUtf8("0000000000000000"));
      var result = jsonDecode(decrypted);
      return result;
    } else {
      return data;
    }
  }
}
