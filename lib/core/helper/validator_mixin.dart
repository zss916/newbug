mixin ValidatorMixin {
  /// 验证密码
  bool isMatchPwd(String? value) {
    if (value == null || value.isEmpty) return false;
    final regex = RegExp(r'^.{8,20}$');
    if (regex.hasMatch(value)) return true;
    return false;
  }
}
