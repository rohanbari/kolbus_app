import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kolbus_app/screens/about_page.dart';
import 'package:kolbus_app/screens/home_page.dart';
import 'package:kolbus_app/screens/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      pageBuilder: (context, state) =>
          fadePageTransition(child: SplashScreen()),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => fadePageTransition(child: HomePage()),
    ),
    GoRoute(
      path: '/about',
      name: 'about',
      pageBuilder: (context, state) => slideHorizontalPageTransition(child: AboutPage()),
    ),
  ],
);

CustomTransitionPage<T> fadePageTransition<T>({required Widget child}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
  );
}

CustomTransitionPage<T> slideHorizontalPageTransition<T>({required Widget child}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: const Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        ),
  );
}
