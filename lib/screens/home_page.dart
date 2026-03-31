import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolbus_app/models/route_model.dart';
import 'package:kolbus_app/screens/backend.dart';
import 'package:kolbus_app/screens/route_card.dart';
import 'package:kolbus_app/vars.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sourceController = TextEditingController();
  final viaController = TextEditingController();
  final destController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    final jsonString = await rootBundle.loadString('assets/routes.json');
    final jsonData = json.decode(jsonString);

    final loadedRoutes = (jsonData['routes'] as List)
        .map((e) => RouteModel.fromJson(e))
        .toList();

    setState(() {
      routes = loadedRoutes;
      aliases = Map<String, String>.from(jsonData['aliases']);

      allStops = {...routes.expand((r) => r.stops), ...aliases.keys};
    });
  }

  void handleSearch() {
    final res = searchRoutes(
      sourceController.text,
      viaController.text,
      destController.text,
    );

    firstRun = false;

    setState(() {
      results = res;
    });
  }

  @override
  void dispose() {
    sourceController.dispose();
    viaController.dispose();
    destController.dispose();
    super.dispose();
  }

  bool firstRun = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KolBus'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildAutoField("Source", sourceController),
            buildAutoField("Via (optional)", viaController),
            buildAutoField("Destination", destController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: handleSearch,
              child: const Text("Search"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: results.isEmpty
                  ? Center(
                      child: Text(
                        firstRun
                            ? "Fill details above and tap Search to see routes."
                            : "No bus routes",
                      ),
                    )
                  : ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final route = results[index];
                        return RouteCard(route: route);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
