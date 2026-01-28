import 'package:flutter/material.dart';

class AppConstants {
  // ===== COLORS =====
  static const Color primaryColor = Color(0xFF4F46E5); // Indigo / Social app style
  static const Color secondaryColor = Color(0xFF06B6D4); // Cyan
  static const Color backgroundColor = Color(0xFFF9FAFB); // Light gray
  static const Color textPrimary = Color(0xFF111827); // Dark text
  static const Color textSecondary = Color(0xFF6B7280); // Gray text
  static const Color errorColor = Color(0xFFEF4444); // Red

  // ===== TEXT STYLES =====
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );

  static const TextStyle smallText = TextStyle(
    fontSize: 12,
    color: textSecondary,
  );
}
