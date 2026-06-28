import 'package:flutter/material.dart';

// Circular avatar with initials fallback
// colorHex is ARGB int from model — converted here in view layer
// Used by: sidebar profile, top creators table, right panel navbar,
//          birthday card, anniversary card, avatar stack
class AppAvatar extends StatelessWidget {
  final int colorHex;
  final String name;
  final double size;
  final double? fontSize;
  final VoidCallback? onTap;

  const AppAvatar({
    super.key,
    required this.colorHex,
    required this.name,
    this.size = 36,
    this.fontSize,
    this.onTap,
  });

  // Extracts up to 2 initials from full name
  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  // Converts ARGB int from model to Flutter Color
  Color get _color => Color(colorHex);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          // Light tint of avatar color as background
          color: _color.withAlpha(40),
          shape: BoxShape.circle,
          border: Border.all(
            color: _color.withAlpha(100),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            _initials,
            style: TextStyle(
              fontSize: fontSize ?? size * 0.35,
              fontWeight: FontWeight.w600,
              color: _color,
            ),
          ),
        ),
      ),
    );
  }
}