import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_enums.dart';
import '../../../models/nav_item_model.dart';
import '../../../shared/widgets/hover_builder.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';

// Single nav row in sidebar
// isCollapsed = icon only, no label
// isActive = blue bg pill + blue icon + bold label
class SidebarNavItem extends StatelessWidget {
  final NavItemModel item;
  final bool isActive;
  final bool isCollapsed;
  final VoidCallback? onTap;

  const SidebarNavItem({
    super.key,
    required this.item,
    required this.isActive,
    required this.isCollapsed,
    this.onTap,
  });

  // Maps NavRoute enum to IconData in view layer
  // Keeps models Flutter-free while still showing correct icons
  IconData _iconFromRoute(NavRoute route) {
    switch (route) {
      case NavRoute.home:
        return Icons.home_rounded;
      case NavRoute.employees:
        return Icons.people_alt_rounded;
      case NavRoute.attendance:
        return Icons.access_time_rounded;
      case NavRoute.summary:
        return Icons.summarize_rounded;
      case NavRoute.information:
        return Icons.info_outline_rounded;
      case NavRoute.settings:
        return Icons.settings_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (isHovered) {
        return GestureDetector(
          onTap: () {
            // Close drawer if open on mobile before navigating
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
            onTap?.call();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 1,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isCollapsed ? 0 : 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.navActiveBg
                  : isHovered
                      ? AppColors.navHoverBg
                      : Colors.transparent,
              borderRadius: AppRadius.mdAll,
            ),
            child: Row(
              mainAxisAlignment: isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Icon(
                  _iconFromRoute(item.route),
                  size: 19,
                  color: isActive
                      ? AppColors.navActive
                      : AppColors.navInactiveText,
                ),
                if (!isCollapsed) ...[
                  const Gap(12),
                  Expanded(
                    child: Text(
                      item.label,
                      style: isActive
                          ? AppTypography.navItemActive
                          : AppTypography.navItem,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}