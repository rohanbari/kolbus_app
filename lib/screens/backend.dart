import 'package:kolbus_app/models/route_model.dart';
import 'package:kolbus_app/vars.dart';

String normalizeStop(String input) {
  if (input.trim().isEmpty) return "";

  final key = input.trim();

  final match = aliases.entries.firstWhere(
    (e) => e.key.toLowerCase() == key.toLowerCase(),
    orElse: () => MapEntry(key, key),
  );

  return match.value;
}

List<String> getSuggestions(String query) {
  if (query.isEmpty) return [];

  final lower = query.toLowerCase();

  final results = allStops
      .where((s) => s.toLowerCase().contains(lower))
      .take(10)
      .toList();

  final completeQuery = results
      .where((element) => element == query)
      .firstOrNull;

  return completeQuery != null ? [] : results;
}

List<RouteModel> searchRoutes(String source, String via, String destination) {
  source = normalizeStop(source);
  via = normalizeStop(via);
  destination = normalizeStop(destination);

  List<RouteModel> matched = [];

  for (var route in routes) {
    final lowerStops = route.stops.map((e) => e.toLowerCase()).toList();

    int sIndex = lowerStops.indexOf(source.toLowerCase());
    int dIndex = lowerStops.indexOf(destination.toLowerCase());

    if (sIndex == -1 || dIndex == -1) continue;
    if (sIndex >= dIndex) continue;

    if (via.isNotEmpty) {
      int vIndex = lowerStops.indexOf(via.toLowerCase());
      if (vIndex == -1) continue;
      if (!(sIndex < vIndex && vIndex < dIndex)) continue;
    }

    matched.add(route);
  }

  return matched;
}
