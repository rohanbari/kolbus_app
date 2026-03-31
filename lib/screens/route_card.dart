import 'package:flutter/material.dart';
import 'package:kolbus_app/models/route_model.dart';
import 'package:kolbus_app/screens/route_details.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({super.key, required this.route});

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Bus ${route.routeId}"),
        subtitle: Text("${route.source} → ${route.destination}"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RouteDetailsPage(route: route)),
          );
        },
      ),
    );
  }
}
