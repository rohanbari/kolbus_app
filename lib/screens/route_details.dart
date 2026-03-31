import 'package:flutter/material.dart';
import 'package:kolbus_app/models/route_model.dart';

class RouteDetailsPage extends StatelessWidget {
  const RouteDetailsPage({super.key, required this.route});

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route ${route.routeId}"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: route.stops.length,
          itemBuilder: (context, index) {
            final stop = route.stops[index];
            return ListTile(leading: Text("${index + 1}"), title: Text(stop));
          },
        ),
      ),
    );
  }
}
