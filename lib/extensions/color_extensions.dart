import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  String toHex({bool leadingHashSign = true}) {
    final r = (this.r * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final g = (this.g * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final b = (this.b * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final rgb = '$r$g$b'.toUpperCase();
    return leadingHashSign ? '#$rgb' : rgb;
  }

  Color withAlphaDouble(double opacity) {
    return withAlpha((opacity.clamp(0.0, 1.0) * 255).round());
  }

  bool get isLight {
    return computeLuminance() > 0.5;
  }

  bool get isDark {
    return computeLuminance() <= 0.5;
  }

  Color get onColor {
    return isLight ? Colors.black : Colors.white;
  }
}

class HexColorParser {
  HexColorParser._();

  static Color fromHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    final fullHex = cleaned.length == 6 ? 'FF$cleaned' : cleaned;
    final intValue = int.parse(fullHex, radix: 16);
    return Color(intValue);
  }
}