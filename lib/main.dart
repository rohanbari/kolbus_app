import 'package:flutter/material.dart';
import 'package:kolbus_app/screens/home_page.dart';

void main() {
  runApp(const KolBusApp());
}

class KolBusApp extends StatelessWidget {
  const KolBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KolBus',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
