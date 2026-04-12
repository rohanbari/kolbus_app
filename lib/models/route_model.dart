import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_model.freezed.dart';
part 'route_model.g.dart';

@freezed
sealed class RouteModel with _$RouteModel {
  factory RouteModel({
    @JsonKey(name: 'route_id') required String routeId,
    required String source,
    required String destination,
    required List<String> stops,
  }) = _RouteModel;

  factory RouteModel.fromJson(Map<String, dynamic> json) => _$RouteModelFromJson(json);
}
