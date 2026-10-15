import 'package:coffe_shop/app/routes/app_pages.dart';
import 'package:coffe_shop/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInjection.configureDependencies();

  final authCubit = AppInjection.getIt<AuthCubit>();
  AppRouter.initialize(authCubit);

  runApp(CoffeeShopApp(authCubit: authCubit, router: AppRouter.router));

  authCubit.restoreSession();
}
