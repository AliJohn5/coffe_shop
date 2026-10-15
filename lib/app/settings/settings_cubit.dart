import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_settings.dart';
import 'settings_storage.dart';

class SettingsCubit extends Cubit<AppSettings> {
  SettingsCubit(this._storage) : super(const AppSettings());

  final SettingsStorage _storage;

  Future<void> load() async {
    final settings = await _storage.loadSettings();
    if (!isClosed) emit(settings);
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    if (state.themeMode == themeMode) return;

    final previous = state;
    emit(state.copyWith(themeMode: themeMode));

    try {
      await _storage.saveThemeMode(themeMode);
    } catch (_) {
      if (!isClosed) emit(previous);
      rethrow;
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    if (!{'en', 'ar'}.contains(languageCode)) {
      throw ArgumentError.value(
        languageCode,
        'languageCode',
        'Supported languages are en and ar',
      );
    }

    if (state.languageCode == languageCode) return;

    final previous = state;
    emit(state.copyWith(languageCode: languageCode));

    try {
      await _storage.saveLanguageCode(languageCode);
    } catch (_) {
      if (!isClosed) emit(previous);
      rethrow;
    }
  }

  Future<void> completeOnboarding() async {
    if (state.onboardingCompleted) return;

    final previous = state;
    emit(state.copyWith(onboardingCompleted: true));

    try {
      await _storage.saveOnboardingCompleted(true);
    } catch (_) {
      if (!isClosed) emit(previous);
      rethrow;
    }
  }
}
