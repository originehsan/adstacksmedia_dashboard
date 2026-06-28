import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

// Horizontal rating bar — width proportional to value (0.0 to 1.0)
// Used in Top Creators table for each creator's rating column
class AppRatingBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Color? fillColor;
  final double height;
  final double? width;

  const AppRatingBar({
    super.key,
    required this.value,
    this.fillColor,
    this.height = 6,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = width ?? constraints.maxWidth;
        return Container(
          width: barWidth,
          height: height,
          decoration:const  BoxDecoration(
            color: AppColors.borderLight,
            borderRadius: AppRadius.pill,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: fillColor ?? AppColors.primary,
                  borderRadius: AppRadius.pill,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}