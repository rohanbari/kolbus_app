import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kolbus_app/routes/app_routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:riverpod_devtools/riverpod_devtools.dart';

Future<void> main() async {
  runApp(
    ProviderScope(
      observers: [RiverpodDevToolsObserver()],
      child: ResponsiveSizer(builder: (p0, p1, p2) => const KolBusApp()),
    ),
  );
}

class KolBusApp extends StatelessWidget {
  const KolBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KolBus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
