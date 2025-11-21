import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static AppTheme of(BuildContext context) {
    return AppTheme();
  }

  late Color primaryColor;
  late Color secondaryColor;
  late Color tertiaryColor;
  late Color alternate;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;
  late Color primary;
  late Color accent1;
  late Color error;

  late TextStyle displayLarge;
  late TextStyle displayMedium;
  late TextStyle displaySmall;
  late TextStyle headlineLarge;
  late TextStyle headlineMedium;
  late TextStyle headlineSmall;
  late TextStyle titleLarge;
  late TextStyle titleMedium;
  late TextStyle titleSmall;
  late TextStyle labelLarge;
  late TextStyle labelMedium;
  late TextStyle labelSmall;
  late TextStyle bodyLarge;
  late TextStyle bodyMedium;
  late TextStyle bodySmall;

  AppTheme() {
    primaryColor = Color(0xFF8C1D40);
    secondaryColor = Color(0xFF39D2C0);
    tertiaryColor = Color(0xFFEE8B60);
    alternate = Color(0xFFE0E3E7);
    primaryBackground = Color(0xFFF1F4F8);
    secondaryBackground = Color(0xFFFFFFFF);
    primaryText = Color(0xFF101213);
    secondaryText = Color(0xFF57636C);
    primary = Color(0xFF8C1D40);
    accent1 = Color(0xFFFFE6E6);
    error = Color(0xFFFF5963);

    displayLarge = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 57,
      fontWeight: FontWeight.w400,
    );
    displayMedium = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 45,
      fontWeight: FontWeight.w400,
    );
    displaySmall = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 36,
      fontWeight: FontWeight.w400,
    );
    headlineLarge = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 32,
      fontWeight: FontWeight.w400,
    );
    headlineMedium = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    );
    headlineSmall = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 24,
      fontWeight: FontWeight.w400,
    );
    titleLarge = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 22,
      fontWeight: FontWeight.w500,
    );
    titleMedium = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
    titleSmall = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    labelLarge = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    labelMedium = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    labelSmall = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );
    bodyLarge = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    bodyMedium = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    bodySmall = TextStyle(
      fontFamily: 'Inter',
      color: primaryText,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );
  }
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
    Object? font,
  }) {
    return copyWith(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      height: lineHeight,
    );
  }
}
