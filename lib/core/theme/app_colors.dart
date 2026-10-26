import 'package:flutter/material.dart';

/// Palet warna resmi SPPGIndonesia Mobile sesuai Design System
class AppColors {
  // Brand Colors
  static const Color primaryNavy = Color(0xFF1A237E);
  static const Color secondaryNavy = Color(0xFF0D47A1);
  static const Color darkNavy = Color(0xFF000051);
  static const Color accentAmber = Color(0xFFFFA000);
  static const Color successGreen = Color(0xFF2E7D32);

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF8F9FA);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF0F4F8);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A24);
  static const Color textSecondary = Color(0xFF5A607F);
  static const Color textLight = Color(0xFFFFFFFF);

  // Status & Utility
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color warningOrange = Color(0xFFED6C02);
  static const Color infoBlue = Color(0xFF0288D1);
  static const Color divider = Color(0xFFE2E8F0);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryNavy, secondaryNavy, darkNavy],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF1A237E), Color(0xFF000051)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
