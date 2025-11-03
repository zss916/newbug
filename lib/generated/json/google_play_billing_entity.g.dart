import 'package:newbug/core/network/model/google_play_billing_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

GooglePlayBillingEntity $GooglePlayBillingEntityFromJson(
  Map<String, dynamic> json,
) {
  final GooglePlayBillingEntity googlePlayBillingEntity =
      GooglePlayBillingEntity();
  final String? upgrade = jsonConvert.convert<String>(json['upgrade']);
  if (upgrade != null) {
    googlePlayBillingEntity.upgrade = upgrade;
  }
  final String? downgrade = jsonConvert.convert<String>(json['downgrade']);
  if (downgrade != null) {
    googlePlayBillingEntity.downgrade = downgrade;
  }
  return googlePlayBillingEntity;
}

Map<String, dynamic> $GooglePlayBillingEntityToJson(
  GooglePlayBillingEntity entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['upgrade'] = entity.upgrade;
  data['downgrade'] = entity.downgrade;
  return data;
}

extension GooglePlayBillingEntityExtension on GooglePlayBillingEntity {
  GooglePlayBillingEntity copyWith({String? upgrade, String? downgrade}) {
    return GooglePlayBillingEntity()
      ..upgrade = upgrade ?? this.upgrade
      ..downgrade = downgrade ?? this.downgrade;
  }
}
