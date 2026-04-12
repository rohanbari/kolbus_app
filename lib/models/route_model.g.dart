// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => _RouteModel(
  routeId: json['route_id'] as String,
  source: json['source'] as String,
  destination: json['destination'] as String,
  stops: (json['stops'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$RouteModelToJson(_RouteModel instance) =>
    <String, dynamic>{
      'route_id': instance.routeId,
      'source': instance.source,
      'destination': instance.destination,
      'stops': instance.stops,
    };
