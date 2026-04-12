import 'package:flutter/material.dart';
import 'package:kolbus_app/routes/app_routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(ResponsiveSizer(builder: (p0, p1, p2) => const KolBusApp()));
}

class KolBusApp extends StatelessWidget {
  const KolBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KolBus',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepOrange, brightness: .dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
