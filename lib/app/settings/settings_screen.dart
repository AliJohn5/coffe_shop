import 'package:coffe_shop/app/settings/app_settings.dart';
import 'package:coffe_shop/core/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coffe_shop/app/settings/settings_cubit.dart';

class AppSettingsSection extends StatelessWidget {
  const AppSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(context.l10n.appTitle),
      ),
      body: BlocBuilder<SettingsCubit, AppSettings>(
        builder: (context, settings) {
          return Column(
            children: [
              ListTile(
                title: Text(context.l10n.appearance),
                trailing: DropdownButton<ThemeMode>(
                  value: settings.themeMode,
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(context.l10n.system),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(context.l10n.light),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(context.l10n.dark),
                    ),
                  ],
                  onChanged: (mode) {
                    if (mode != null) {
                      cubit.changeTheme(mode);
                    }
                  },
                ),
              ),
              ListTile(
                title: Text(context.l10n.language),
                trailing: DropdownButton<String>(
                  value: settings.languageCode,
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'ar', child: Text('العربية')),
                  ],
                  onChanged: (language) {
                    if (language == null) return;

                    context.read<SettingsCubit>().changeLanguage(language);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
