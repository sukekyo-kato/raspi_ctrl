import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:raspi_ctrl_app/ui/launch_page.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const LaunchPage();
          },
        ),
      ],
      redirect: (context, state) {
        return null;
      },
    );
  },
);
