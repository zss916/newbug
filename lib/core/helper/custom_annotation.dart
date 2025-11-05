import 'package:get/get.dart';

class CustomAnnotation {
  final String description;
  const CustomAnnotation({this.description = ''});
}

S? safeFind<S>() {
  if (Get.isRegistered<S>() == true) {
    final s = Get.find<S>();
    return s;
  }
  return null;
}
