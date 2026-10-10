import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kolbus_app/models/app_data.dart';
import 'package:kolbus_app/models/route_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_provider.g.dart';

@riverpod
class Data extends _$Data {
  @override
  FutureOr<AppDataModel> build() async {
    final jsonString = await rootBundle.loadString('assets/routes.json');
    final jsonData = json.decode(jsonString);

    final loadedRoutes = (jsonData['routes'] as List)
        .map((e) => RouteModel.fromJson(e))
        .toList();
    final aliases = Map<String, String>.from(jsonData['aliases']);
    final allStops = {...loadedRoutes.expand((r) => r.stops), ...aliases.keys};

    return AppDataModel(
      routes: loadedRoutes,
      aliases: aliases,
      allStops: allStops,
      results: [],
    );
  }

  void setRoutes(List<RouteModel> routes) {
    final currentValue = state.value;
    if (currentValue != null) {
      state = AsyncData(currentValue.copyWith(routes: routes));
    }
  }

  void setResults(List<RouteModel> results) {
    final currentValue = state.value;
    if (currentValue != null) {
      state = AsyncData(currentValue.copyWith(results: results));
    }
  }

  void setAliases(Map<String, String> aliases) {
    final currentValue = state.value;
    if (currentValue != null) {
      state = AsyncData(currentValue.copyWith(aliases: aliases));
    }
  }

  void setAllStops(Set<String> allStops) {
    final currentValue = state.value;
    if (currentValue != null) {
      state = AsyncData(currentValue.copyWith(allStops: allStops));
    }
  }

  Future<bool> viaEnabled(String source) async {
    if (source.trim().length >= 3) {
      return state.value?.allStops.contains(source) ?? false;
    } else {
      return false;
    }
  }
}
