import 'package:flutter/material.dart';

class ColorUtils {
  ColorUtils._();

  static Color fromHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    final fullHex = cleaned.length == 6 ? 'FF$cleaned' : cleaned;
    final intValue = int.parse(fullHex, radix: 16);
    return Color(intValue);
  }

  static Color fromInt(int colorHex) {
    return Color(colorHex);
  }

  static Color avatarColorFromIndex(int index) {
    const colors = [
      Color(0xFF4A6CF7),
      Color(0xFFEF4444),
      Color(0xFF22C55E),
      Color(0xFFF59E0B),
      Color(0xFF8B5CF6),
    ];
    return colors[index % colors.length];
  }

  static Color avatarColorFromName(String name) {
    final index = name.isEmpty ? 0 : name.codeUnitAt(0) % 5;
    return avatarColorFromIndex(index);
  }
}