

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class RouterNestedConfig {
  static GoRoute createRoute(
    String path,
    Widget Function(Map<String, dynamic>) pageContent,
  ) {
    return GoRoute(
      path: path,
      name: path,
      pageBuilder: (context, state) {
        var sample = state.extra as Map<String, dynamic>;
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: pageContent(sample),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  static GoRoute createRouteWithoutParam(
    String path,
    Widget pageContent,
  ) {
    return GoRoute(
      path: path,
      name: path,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: pageContent,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  

// static GoRoute goRouteSplash() => createRouteWithoutParam(
//       MyRoutes.splash,
//       const SplashScreen(),
//     );
}
