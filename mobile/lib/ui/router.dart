import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:raspi_ctrl_app/ui/home/home_page.dart';
import 'package:raspi_ctrl_app/ui/launch_page.dart';
import 'package:raspi_ctrl_app/ui/login/signin_page.dart';
import 'package:raspi_ctrl_app/ui/login/signup_page.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: HomePage.routerPath,
      routes: <RouteBase>[
        GoRoute(
          name: HomePage.routerName,
          path: HomePage.routerPath,
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          name: LaunchPage.routerName,
          path: LaunchPage.routerPath,
          builder: (BuildContext context, GoRouterState state) {
            return const LaunchPage();
          },
        ),
        GoRoute(
          name: SignUpPage.routerName,
          path: SignUpPage.routerPath,
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpPage();
          },
        ),
        GoRoute(
          name: SignInPage.routerName,
          path: SignInPage.routerPath,
          builder: (BuildContext context, GoRouterState state) {
            return const SignInPage();
          },
        ),
      ],
      redirect: (context, state) {
        if (_needLogin(state.subloc)) {
          return LaunchPage.routerPath;
        }
        return null;
      },
    );
  },
);

bool _needLogin(String subloc) {
  return ![LaunchPage.routerPath, SignUpPage.routerPath, SignInPage.routerPath]
      .contains(subloc);
}
