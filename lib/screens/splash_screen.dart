import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kolbus_app/providers/data_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dp = ref.watch(dataProvider);
    return Scaffold(
      body: Center(
        child: dp.when(
          data: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.goNamed('home');
            },);
            return Text('Database loaded...');
          },
          error: (error, stackTrace) {
            Center(child: Text('Failed to load database due to : ${error}'));
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
