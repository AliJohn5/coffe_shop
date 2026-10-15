import 'package:flutter/material.dart';

class AppSettings {
  final ThemeMode themeMode;
  final String languageCode;
  final bool onboardingCompleted;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.languageCode = 'en',
    this.onboardingCompleted = false,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? languageCode,
    bool? onboardingCompleted,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    );
  }
}
