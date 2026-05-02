import 'package:flutter/material.dart';

import 'color_constant.dart';

class AppTheme {
  static OutlineInputBorder _border({
    Color color = ColorConstant.borderMuted,
    double width = 1.2,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: ColorConstant.background,
    colorScheme: const ColorScheme.dark(
      primary: ColorConstant.appColor,
      secondary: ColorConstant.lightPinkColor,
      surface: ColorConstant.surface,
      onSurface: ColorConstant.textPrimary,
      onPrimary: ColorConstant.whiteColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConstant.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: ColorConstant.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorConstant.surfaceStrong,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      hintStyle: const TextStyle(color: ColorConstant.textMuted),
      enabledBorder: _border(),
      focusedBorder: _border(color: ColorConstant.appColor, width: 1.6),
      errorBorder: _border(color: Colors.redAccent.withValues(alpha: 0.75)),
      focusedErrorBorder: _border(color: Colors.redAccent),
    ),
    dividerTheme: const DividerThemeData(color: ColorConstant.borderMuted),
    dialogTheme: DialogThemeData(
      backgroundColor: ColorConstant.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    splashFactory: InkRipple.splashFactory,
  );
}
