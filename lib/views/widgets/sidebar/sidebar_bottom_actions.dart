import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/app_enums.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/hover_builder.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../../../viewmodels/dashboard_provider.dart';

// Settings and Logout items pinned to bottom of sidebar
// Settings — blue active state
// Logout — red tint to signal danger action
class SidebarBottomActions extends ConsumerWidget {
  final bool isCollapsed;
  final NavRoute activeRoute;

  const SidebarBottomActions({
    super.key,
    required this.isCollapsed,
    required this.activeRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 0.5),
        // Settings item
        _BottomNavItem(
          icon: Icons.settings_outlined,
          label: AppStrings.navSettings,
          isCollapsed: isCollapsed,
          isActive: activeRoute == NavRoute.settings,
          iconColor: activeRoute == NavRoute.settings
              ? AppColors.navActive
              : AppColors.textSecondary,
          activeColor: AppColors.navActiveBg,
          onTap: () => ref
              .read(dashboardProvider.notifier)
              .selectNav(NavRoute.settings),
        ),
        // Logout item — red tint
        _BottomNavItem(
          icon: Icons.logout_rounded,
          label: AppStrings.navLogout,
          isCollapsed: isCollapsed,
          isActive: false,
          iconColor: AppColors.danger,
          activeColor: AppColors.dangerLight,
          onTap: () {},
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// Custom bottom nav item with configurable colors
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isCollapsed;
  final bool isActive;
  final Color iconColor;
  final Color activeColor;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isCollapsed,
    required this.isActive,
    required this.iconColor,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (isHovered) {
        return GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
            onTap();
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
                  ? activeColor
                  : isHovered
                      ? activeColor.withAlpha(80)
                      : Colors.transparent,
              borderRadius: AppRadius.mdAll,
            ),
            child: Row(
              mainAxisAlignment: isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 19,
                  color: iconColor,
                ),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: AppTypography.navItem.copyWith(
                        color: iconColor,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
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