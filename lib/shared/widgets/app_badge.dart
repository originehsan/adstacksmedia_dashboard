import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

// Generic pill badge — used for role label, count display, status tags
// backgroundColor and textColor default to primary theme colors
class AppBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsets? padding;

  const AppBadge({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.primaryLight,
    this.textColor = AppColors.primary,
    this.fontSize = 11,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 3,
          ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}