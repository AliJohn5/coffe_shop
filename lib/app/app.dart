import 'package:coffe_shop/app/settings/app_settings.dart';
import 'package:coffe_shop/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:coffe_shop/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import 'di/injection.dart';
import 'settings/settings_cubit.dart';

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({
    super.key,
    required this.authCubit,
    required this.router,
  });

  final AuthCubit authCubit;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>.value(
          value: AppInjection.getIt<SettingsCubit>(),
        ),
        BlocProvider<AuthCubit>.value(value: authCubit),
      ],
      child: BlocBuilder<SettingsCubit, AppSettings>(
        builder: (context, settings) {
          return MaterialApp.router(
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,
            locale: Locale(settings.languageCode),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('ar')],
            routerConfig: router,
          );
        },
      ),
    );
  }
}
