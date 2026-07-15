import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Ilovaning tipografiya tizimi.
///
/// Dizaynda ikki shrift ishlatilgan:
///  • Manrope   — asosiy (sans-serif) matnlar;
///  • Newsreader — sarlavhalar (serif) uchun.
///
/// `google_fonts` orqali yuklanadi, shu sababli asset fayllar shart emas.
class AppTextStyles {
  const AppTextStyles._();

  // ── Serif sarlavhalar (Newsreader) ────────────────────────────
  static TextStyle serif({
    double fontSize = 22,
    FontWeight fontWeight = FontWeight.w600,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.newsreader(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // ── Sans matnlar (Manrope) ────────────────────────────────────
  static TextStyle sans({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.manrope(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  /// Butun ilova uchun Manrope asosidagi TextTheme.
  static TextTheme textTheme(Color primary, Color secondary) {
    final base = GoogleFonts.manropeTextTheme();
    return base.apply(bodyColor: primary, displayColor: primary);
  }
}
