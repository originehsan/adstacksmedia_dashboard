import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'hover_builder.dart';

// Filled primary CTA button — used in hero project card "Learn More"
class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? prefixIcon;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;

  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.prefixIcon,
    this.width,
    this.height = 36,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHovered) {
        return GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isHovered
                  ? (backgroundColor ?? AppColors.primaryDark)
                  : (backgroundColor ?? AppColors.primary),
              borderRadius: AppRadius.smAll,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: textColor ?? AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}