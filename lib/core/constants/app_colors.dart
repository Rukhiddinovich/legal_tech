import 'package:flutter/material.dart';

/// Adolat dizayn tizimining rang palitrasi.
///
/// Barcha ranglar dizayn maketidan (LegalTechDizayn) olingan.
/// Instansiya qilinmaydi — faqat statik konstantalar.
class AppColors {
  const AppColors._();

  // ── Brend (navy) ──────────────────────────────────────────────
  /// Asosiy to'q ko'k — header, tugma, brend.
  static const Color navy = Color(0xFF0F2233);

  /// Matn uchun to'q ko'k.
  static const Color navyText = Color(0xFF12222F);

  /// Avatar gradientining ochiq tomoni.
  static const Color navyLight = Color(0xFF274257);

  // ── Aksent (gold / bronze) ────────────────────────────────────
  static const Color gold = Color(0xFFC6A25E);
  static const Color goldDark = Color(0xFFA9863F);
  static const Color goldSoft = Color(0x21A6863F); // rgba(166,134,63,.13)

  // ── Fon (beige) ───────────────────────────────────────────────
  static const Color scaffold = Color(0xFFF4F2EC);
  static const Color scaffoldAlt = Color(0xFFECE9E1);
  static const Color beige = Color(0xFFE7E3DB);
  static const Color chipBg = Color(0xFFF0EEE7);
  static const Color paperBg = Color(0xFFFBFAF7);

  // ── Holat (status) ────────────────────────────────────────────
  static const Color online = Color(0xFF35A46B);
  static const Color onlineDark = Color(0xFF2A8A58);
  static const Color danger = Color(0xFFE0524E);

  // ── Matn ──────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF12222F);
  static const Color textSecondary = Color(0xFF5C6772);
  static const Color textMuted = Color(0xFF8A93A0);
  static const Color textHint = Color(0xFF98A0AA);

  // ── Neytral ───────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color divider = Color(0x120F2233); // rgba(15,34,51,.07)
  static const Color border = Color(0x0F0F2233); // rgba(15,34,51,.06)
  static const Color borderStrong = Color(0x1F0F2233); // rgba(15,34,51,.12)

  // ── To'lov brendlari ──────────────────────────────────────────
  static const Color payme = Color(0xFF00CFB4);
  static const Color click = Color(0xFF1A73E8);
  static const Color uzum = Color(0xFF7C3AED);

  // ── Dark rejim ────────────────────────────────────────────────
  static const Color darkScaffold = Color(0xFF0B141C);
  static const Color darkSurface = Color(0xFF13212C);
  static const Color darkCard = Color(0xFF17262F);
  static const Color darkBorder = Color(0x1FFFFFFF);
  static const Color darkTextPrimary = Color(0xFFF1F3F5);
  static const Color darkTextSecondary = Color(0xFFAEB8C2);

  // ── Gradientlar ───────────────────────────────────────────────
  static const LinearGradient avatarGradient = LinearGradient(
    begin: Alignment(-0.6, -1),
    end: Alignment(0.6, 1),
    colors: [navyLight, navyText],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment(-0.6, -1),
    end: Alignment(0.6, 1),
    colors: [gold, goldDark],
  );
}
