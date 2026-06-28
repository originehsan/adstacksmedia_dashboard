import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'hover_builder.dart';

// Reusable icon button with hover state and optional tooltip
// Used by: right panel navbar, project list edit icon, sidebar bottom actions
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String? tooltip;
  final Color? iconColor;
  final Color? hoverColor;
  final double size;
  final double iconSize;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.tooltip,
    this.iconColor,
    this.hoverColor,
    this.size = 32,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    final button = Semantics(
      label: tooltip ?? 'Icon button',
      button: true,
      child: HoverBuilder(
        cursor: SystemMouseCursors.click,
        builder: (isHovered) {
          return GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color:
                    isHovered
                        ? (hoverColor ?? AppColors.borderLight)
                        : Colors.transparent,
                borderRadius: AppRadius.smAll,
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor ?? AppColors.textSecondary,
              ),
            ),
          );
        },
      ),
    );

    // Wrap with tooltip only if provided
    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        triggerMode: TooltipTriggerMode.tap,
        child: button,
      );
    }

    return button;
  }
}
