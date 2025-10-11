import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final base = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0ABE7E)),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(
        fontFamily: 'Roboto',
      ),
      appBarTheme: const AppBarTheme(centerTitle: true),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
        ),
      ),
      cardTheme: base.cardTheme.copyWith(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0ABE7E),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(
        fontFamily: 'Roboto',
      ),
      appBarTheme: const AppBarTheme(centerTitle: true),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
        ),
      ),
      cardTheme: base.cardTheme.copyWith(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        margin: const EdgeInsets.all(8),
      ),
    );
  }
}
