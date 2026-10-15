import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings.dart';

class SettingsStorage {
  static const _themeKey = 'theme_mode';
  static const _languageKey = 'language_code';
  static const _onboardingKey = 'onboarding_completed';

  final SharedPreferencesAsync _preferences;

  SettingsStorage(this._preferences);

  Future<AppSettings> loadSettings() async {
    final themeName = await _preferences.getString(_themeKey);
    final languageCode = await _preferences.getString(_languageKey);
    final onboardingCompleted = await _preferences.getBool(_onboardingKey);

    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
        (mode) => mode.name == themeName,
        orElse: () => ThemeMode.system,
      ),
      languageCode: languageCode ?? 'en',
      onboardingCompleted: onboardingCompleted ?? false,
    );
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await _preferences.setString(_themeKey, mode.name);
  }

  Future<void> saveLanguageCode(String languageCode) async {
    await _preferences.setString(_languageKey, languageCode);
  }

  Future<void> saveOnboardingCompleted(bool completed) async {
    await _preferences.setBool(_onboardingKey, completed);
  }
}
