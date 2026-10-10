import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kolbus_app/models/route_model.dart';

class RouteDetailsPage extends ConsumerWidget {
  const RouteDetailsPage({
    super.key,
    required this.route,
    required this.source,
    required this.destination,
  });

  final RouteModel route;
  final String source;
  final String destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lowerStops = route.stops.map((e) => e.toLowerCase()).toList();

    final sIndex = lowerStops.indexOf(source.toLowerCase());
    final dIndex = lowerStops.indexOf(destination.toLowerCase());

    return Scaffold(
      appBar: AppBar(title: Text("Route ${route.routeId}")),
      body: ListView.builder(
        itemCount: route.stops.length,
        itemBuilder: (context, index) {
          final stop = route.stops[index];

          final isBetween =
              sIndex != -1 &&
              dIndex != -1 &&
              index >= sIndex &&
              index <= dIndex;

          return ListTile(
            tileColor: isBetween ? Colors.lightBlue : Colors.white,
            leading: Text(
              "${index + 1}",
              style: TextStyle(color: isBetween ? Colors.white : Colors.black),
            ),
            title: Text(
              stop,
              style: TextStyle(
                color: isBetween ? Colors.white : Colors.black,
                fontWeight: isBetween ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }
}
