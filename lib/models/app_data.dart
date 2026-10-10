

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kolbus_app/models/route_model.dart';

part 'app_data.freezed.dart';

@freezed
sealed class AppDataModel with _$AppDataModel {
  factory AppDataModel({
    @Default([]) List<RouteModel> routes,
    @Default([]) List<RouteModel> results,
    @Default({}) Map<String, String> aliases,
    @Default({}) Set<String> allStops,
  }) = _AppData;
}
