import 'dart:convert';
import 'dart:typed_data';

class Base64 {
  // 使用Base64编码字符串
  static String encode(String plainText) {
    // 将字符串转换为字节数组，然后进行Base64编码
    final Uint8List bytes = Uint8List.fromList(plainText.codeUnits);
    return base64Encode(bytes);
  }

  // 使用Base64解码字符串
  static String decode(String encodedText) {
    // 将Base64编码的字符串解码为字节数组，然后转换为字符串
    final Uint8List bytes = Uint8List.fromList(base64Decode(encodedText));
    return String.fromCharCodes(bytes);
  }
}
