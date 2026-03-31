class RouteModel {
  final String routeId;
  final String source;
  final String destination;
  final List<String> stops;
  final String timing;

  RouteModel({
    required this.routeId,
    required this.source,
    required this.destination,
    required this.stops,
    required this.timing,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      routeId: json['route_id'] ?? '',
      source: json['source'] ?? '',
      destination: json['destination'] ?? '',
      stops: List<String>.from(json['stops'] ?? []),
      timing: json['timing'] ?? '',
    );
  }
}
