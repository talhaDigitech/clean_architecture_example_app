import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// App Colors Tokens
class AppColors {
  AppColors._();

  // Brand Colors - Primary
  static const Color primary = Color(0xFF0E5C8A);
  static const Color primaryLight = Color(0xFF38BDF8);
  static const Color primaryDark = Color(0xFF073B59);

  // Brand Colors - Secondary
  static const Color secondary = Color(0xFFF0F9FF);
  static const Color secondaryGray = Color(0xFFF8FAFC);
  static const Color secondaryText = Color(0xFF64748B);

  // Accent Colors
  static const Color accent = Color(0xFF0284C7);
  static const Color accentLight = Color(0xFFE0F2FE);

  // Neutral Colors
  static const Color neutral100 = Color(0xFFF8FAFC);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textInverse = Colors.white;

  // Background Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color primarybackground = Color(0xFFF8FAFC);
  static const Color backgroundSecondary = Color(0xFFF1F5F9);
  static const Color backgroundTertiary = Color(0xFFE2E8F0);
  static const Color backgroundPrimary = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkbackgroundPrimary = Color(0xFF1E293B);

  // Border Colors
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderSecondary = Color(0xFFCBD5E1);
  static const Color borderGrey = Color(0xFFE2E8F0);
  static const Color borderFocus = primary;

  // Semantic/Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  static const Color errorRed = CupertinoColors.destructiveRed;

  // Base Colors
  static const Color white = Colors.white;
  static const Color black = Color(0xff1f1f1f);
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color.fromARGB(255, 229, 229, 229);

  // Special/Brand Colors
  static const Color lightGreen = Color.fromRGBO(7, 133, 103, 1);
  static const Color groceryGreen = Color.fromRGBO(69, 161, 123, 1);
  static const Color pickledRadish = Color(0xFFEE1843);
  static const Color carrotOrange = Color(0xFFEA8822);
  static const Color utahCrimson = Color(0xFFCD0D3C);
  static const Color cerise = Color(0xFFE1335E);
  static const Color vividTangelo = Color(0xFFF57222);
  static const Color piggyPink = Color(0xFFFFE3EA);
  static const Color fadedRed = Color(0xFFE1335E);

  // Divider Colors
  static const Color divider = Color.fromARGB(255, 236, 232, 232);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF1F2937);

  // Special/Overlay
  static const Color overlay = Color(0x66000000);
  static const Color disabled = Color(0xFFD1D5DB);

  // ─────────────────────────────────────────────────────────────────────────
  // Backward Compatibility Aliases (from utils/app_colors.dart)
  // ─────────────────────────────────────────────────────────────────────────
  static const Color brandPrimary = primary;
  static const Color brandLight = Color.fromARGB(255, 250, 138, 168);
  static const Color brandDark = primaryDark;
  static const Color secondaryPink = secondary;
  static const Color accentRed = accent;
  static const Color accentPink = accentLight;
  static const Color borderPrimary = border;
  static const Color primaryWhite = white;
  static const Color primaryBlack = black;
  static const Color primaryGrey = grey;
  static const Color bordergreyColor = borderGrey;
  static const Color lightgreyColor = lightGrey;
  static const Color dividerColor = divider;
  static const Color ceramic = white;
  static const Color itemsbackground = Color.fromARGB(255, 249, 249, 249);
}
