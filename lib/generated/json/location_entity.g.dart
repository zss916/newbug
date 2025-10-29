import 'package:newbug/core/network/model/location_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

LocationEntity $LocationEntityFromJson(Map<String, dynamic> json) {
  final LocationEntity locationEntity = LocationEntity();
  final int? statesId = jsonConvert.convert<int>(json['states_id']);
  if (statesId != null) {
    locationEntity.statesId = statesId;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    locationEntity.address = address;
  }
  return locationEntity;
}

Map<String, dynamic> $LocationEntityToJson(LocationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['states_id'] = entity.statesId;
  data['address'] = entity.address;
  return data;
}

extension LocationEntityExtension on LocationEntity {
  LocationEntity copyWith({int? statesId, String? address}) {
    return LocationEntity()
      ..statesId = statesId ?? this.statesId
      ..address = address ?? this.address;
  }
}
