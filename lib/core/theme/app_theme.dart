import 'package:flutter/material.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  final Color primary;
  final Color secondary;
  final Color text;
  final Color muted;
  final Color background;

  const AppPalette({
    required this.primary,
    required this.secondary,
    required this.text,
    required this.muted,
    required this.background,
  });

  // Light palette from the original design.
  static const light = AppPalette(
    primary: Color(0xFFC67C4E),
    secondary: Color(0xFFEDD6C8),
    text: Color(0xFF313131),
    muted: Color(0xFFE3E3E3),
    background: Color(0xFFF9F2ED),
  );

  // Dark palette from the generated design.
  static const dark = AppPalette(
    primary: Color(0xFFB67852),
    secondary: Color(0xFFD6BBA7),
    text: Color(0xFF1F1F1F),
    muted: Color(0xFF3A3A3A),
    background: Color(0xFF2A2A2A),
  );

  // Derived colors for common UI elements.
  Color get surface => background;
  Color get card => muted;
  Color get border => muted;
  Color get onPrimary => Colors.white;
  Color get onSecondary => text;
  Color get onBackground =>
      background.computeLuminance() > 0.5 ? text : const Color(0xFFF9F2ED);
  Color get secondaryText => background.computeLuminance() > 0.5
      ? const Color(0xFF8A8A8A)
      : const Color(0xFFAAAAAA);
  Color get progressTrack => secondary;

  @override
  AppPalette copyWith({
    Color? primary,
    Color? secondary,
    Color? text,
    Color? muted,
    Color? background,
  }) {
    return AppPalette(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      background: background ?? this.background,
    );
  }

  @override
  AppPalette lerp(covariant AppPalette? other, double t) {
    if (other == null) return this;

    return AppPalette(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      text: Color.lerp(text, other.text, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      background: Color.lerp(background, other.background, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(AppPalette.light);
  static ThemeData get dark => _build(AppPalette.dark);

  static ThemeData _build(AppPalette palette) {
    final isDark = palette.background.computeLuminance() < 0.5;

    final scheme = ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: palette.primary,
      onPrimary: palette.onPrimary,
      secondary: palette.secondary,
      onSecondary: palette.onSecondary,
      error: const Color(0xFFBA1A1A),
      onError: Colors.white,
      surface: palette.background,
      onSurface: palette.onBackground,
      outline: palette.muted,
      outlineVariant: palette.muted,
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: palette.text,
      onInverseSurface: palette.background,
      inversePrimary: AppPalette.light.primary,
      tertiary: palette.secondary,
      onTertiary: palette.text,
      surfaceContainerHighest: palette.muted,
      surfaceContainerHigh: palette.muted,
      surfaceContainer: palette.background,
      surfaceContainerLow: palette.background,
      surfaceContainerLowest: palette.background,
    );

    final textTheme =
        ThemeData(
          brightness: scheme.brightness,
          useMaterial3: true,
        ).textTheme.apply(
          bodyColor: palette.onBackground,
          displayColor: palette.onBackground,
          fontFamily: 'Sora',
        );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: palette.background,
      canvasColor: palette.background,
      cardColor: palette.background,
      dividerColor: palette.muted,
      fontFamily: 'Sora',
      textTheme: textTheme,

      extensions: <ThemeExtension<dynamic>>[palette],

      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: palette.onBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      cardTheme: CardThemeData(
        color: palette.background,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: palette.muted.withValues(alpha: 0.5)),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.onBackground,
          side: BorderSide(color: palette.muted),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.muted.withValues(alpha: 0.25),
        hintStyle: TextStyle(color: palette.secondaryText),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: palette.muted),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: palette.muted),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: palette.primary, width: 1.5),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: palette.muted,
        thickness: 1,
        space: 1,
      ),

      iconTheme: IconThemeData(color: palette.onBackground),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: palette.primary,
        linearTrackColor: palette.progressTrack,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: palette.text,
        contentTextStyle: TextStyle(
          color: palette.background,
          fontFamily: 'Sora',
        ),
        behavior: SnackBarBehavior.floating,
      ),

      listTileTheme: ListTileThemeData(
        iconColor: palette.primary,
        textColor: palette.onBackground,
      ),
    );
  }
}
