mixin ValidatorMixin {
  /// 验证密码
  bool matchPwd(String? value) {
    if (value == null || value.isEmpty) return false;
    final regex = RegExp(r'^.{8,20}$');
    if (regex.hasMatch(value)) return true;
    return false;
  }

  /// 验证用户名
  bool matchName(String? value) {
    if (value == null || value.isEmpty) return false;
    final regex = RegExp(r'^.{0,30}$');
    if (regex.hasMatch(value)) return true;
    return false;
  }
}
