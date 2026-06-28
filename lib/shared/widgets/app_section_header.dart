import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import 'hover_builder.dart';

// Section title row with optional trailing action link
// Used by: all projects, top creators, performance chart sections
class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final Widget? trailing;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTypography.sectionTitle,
        ),
        const Spacer(),
        // Custom trailing widget takes priority over actionLabel
        if (trailing != null)
          trailing!
        else if (actionLabel != null)
          HoverBuilder(
            builder: (isHovered) {
              return GestureDetector(
                onTap: onActionTap,
                child: Text(
                  actionLabel!,
                  style: AppTypography.bodyMd.copyWith(
                    color: isHovered
                        ? AppColors.primaryDark
                        : AppColors.primary,
                    decoration: isHovered
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}