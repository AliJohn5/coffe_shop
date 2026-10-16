import 'package:coffe_shop/app/routes/splash_page.dart';
import 'package:coffe_shop/app/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'app_routes.dart';
import 'auth_router_refresh.dart';

class AppRouter {
  static late AuthCubit authCubit;
  static late AuthRouterRefresh refresh;
  static late GoRouter router;
  static late GlobalKey<NavigatorState> rootNavigatorKey;

  static void initialize(AuthCubit authCubit) {
    AppRouter.authCubit = authCubit;
    refresh = AuthRouterRefresh(authCubit);
    initializeRouter();
  }

  static void initializeRouter() {
    rootNavigatorKey = GlobalKey<NavigatorState>();
    router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: AppRoutes.home,
      refreshListenable: refresh,
      redirect: (context, state) {
        final status = authCubit.state.status;
        final location = state.matchedLocation;
        debugPrint("$status, $location}");

        if (status == AuthStatus.initial || status == AuthStatus.checking) {
          return AppRoutes.splash;
        }

        final isAuthenticated = status == AuthStatus.authenticated;

        final isAuthPage =
            location == AppRoutes.login || location == AppRoutes.register;

        if (!isAuthenticated &&
            location != AppRoutes.login &&
            location != AppRoutes.register) {
          return AppRoutes.login;
        }

        if (isAuthenticated && (isAuthPage || location == AppRoutes.splash)) {
          return AppRoutes.home;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),

        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashPage(),
        ),

        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const AppSettingsSection(),
        ),

        GoRoute(
          //TODO: make forget password
          path: AppRoutes.forgetPasseord,
          builder: (context, state) => const LoginPage(),
        ),
      ],
    );
  }

  static void toNamed(String location) {
    router.push(location);
  }

  static void offNamed(String location) {
    router.go(location);
  }

  static void offAllNamed(String location) {
    router.go(location);
  }

  static void back<T extends Object?>({T? result}) {
    router.pop(result);
  }
}
