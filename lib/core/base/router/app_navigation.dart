import 'package:bot_toast/bot_toast.dart';
import 'package:doit_today/view/Profile/view/profile_view.dart';
import 'package:doit_today/view/layout/view/layout_view.dart';
import 'package:doit_today/view/notes/view/notes_view.dart';
import 'package:doit_today/view/tasks/view/tasks_view.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';


final class AppNavigation {
  AppNavigation._();

  static final GoRouter router = GoRouter(
    initialLocation: '/${MyRoutes.notes}',
    restorationScopeId: 'app',
    debugLogDiagnostics: kDebugMode,
    observers: [BotToastNavigatorObserver()],
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return LayoutView(navigationShell: navigationShell);
        },
        branches: [
        
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${MyRoutes.tasks}',
                name: MyRoutes.tasks,
                builder: (context, state) => const TasksView(),
              ),
            ],
          ),
          // Notes Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${MyRoutes.notes}',
                name: MyRoutes.notes,
                builder: (context, state) => const NotesView(),
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${MyRoutes.profile}',
                name: MyRoutes.profile,
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
class MyRoutes {
  static const String init = "/";

  static const String layout = "layout";
  static const String tasks = "tasks";
  static const String notes = "notes";
  static const String profile = "profile";
}

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
