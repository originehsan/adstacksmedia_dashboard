import 'package:flutter/material.dart';

// Circular avatar — shows real image if imagePath provided
// Falls back to colored initials circle if no image
// Used by: sidebar profile, top creators table, right panel navbar,
//          birthday card, anniversary card, avatar stack
class AppAvatar extends StatelessWidget {
  final int colorHex;
  final String name;
  final double size;
  final double? fontSize;
  final VoidCallback? onTap;
  final String? imagePath; // local asset path — shows real photo if provided

  const AppAvatar({
    super.key,
    required this.colorHex,
    required this.name,
    this.size = 36,
    this.fontSize,
    this.onTap,
    this.imagePath,
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
          shape: BoxShape.circle,
          color: _color.withAlpha(40),
          border: Border.all(
            color: _color.withAlpha(100),
            width: 1.5,
          ),
        ),
        child: ClipOval(
          child: imagePath != null
              // Real photo — asset image with fallback
              ? Image.asset(
                  imagePath!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to initials if image fails to load
                    return _buildInitials();
                  },
                )
              // No image — show colored initials
              : _buildInitials(),
        ),
      ),
    );
  }

  Widget _buildInitials() {
    return Container(
      width: size,
      height: size,
      color: _color.withAlpha(40),
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
    );
  }
}