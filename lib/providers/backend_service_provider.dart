import 'package:kolbus_app/models/route_model.dart';
import 'package:kolbus_app/providers/data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backend_service_provider.g.dart';

@riverpod
class NormalizeStop extends _$NormalizeStop {
  @override
  FutureOr<String> build(String input) async {
    if (input.trim().isEmpty) return '';

    final key = input.trim();
    final aliases = await ref
        .read(dataProvider.future)
        .then((value) => value.aliases);

    final match = aliases.entries.firstWhere(
      (e) => e.key.toLowerCase() == key.toLowerCase(),
      orElse: () => MapEntry(key, key),
    );
    return match.value;
  }
}

@riverpod
class Suggestions extends _$Suggestions {
  @override
  FutureOr<List<String>> build(String query) async {
    if (query.isEmpty) return [];

    final lower = query.toLowerCase();
    final allStops = await ref
        .read(dataProvider.future)
        .then((value) => value.allStops);

    final results = allStops
        .where((s) => s.toLowerCase().contains(lower))
        .take(10)
        .toList();

    final completeQuery = results
        .where((element) => element == query)
        .firstOrNull;

    return completeQuery != null ? [] : results;
  }
}

@Riverpod(keepAlive: true)
class SearchRoutes extends _$SearchRoutes {
  @override
  FutureOr<List<RouteModel>> build({
    String? source,
    String via = '',
    String? destination,
  }) async {
    if (source == null || destination == null) return [];

    final _source = await ref.read(normalizeStopProvider(source).future);
    final _via = await ref.read(normalizeStopProvider(via).future);
    final _destination = await ref.read(
      normalizeStopProvider(destination).future,
    );

    final routes = await ref
        .read(dataProvider.future)
        .then((value) => value.routes);
    List<RouteModel> matched = [];

    for (var route in routes) {
      final lowerStops = route.stops.map((e) => e.toLowerCase()).toList();

      int sIndex = lowerStops.indexOf(_source.toLowerCase());
      int dIndex = lowerStops.indexOf(_destination.toLowerCase());

      if (sIndex == -1 || dIndex == -1) continue;
      if (sIndex >= dIndex) continue;

      if (_via.isNotEmpty) {
        int vIndex = lowerStops.indexOf(_via.toLowerCase());
        if (vIndex == -1) continue;
        if (!(sIndex < vIndex && vIndex < dIndex)) continue;
      }

      matched.add(route);
    }

    return matched;
  }
}
