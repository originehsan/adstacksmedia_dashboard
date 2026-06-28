import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/app_enums.dart';
import '../../../constants/app_strings.dart';
import '../../../models/nav_item_model.dart';
import '../../../viewmodels/dashboard_provider.dart';
import 'sidebar_nav_item.dart';

// Settings and Logout items pinned to bottom of sidebar
// Settings updates activeRoute, Logout is a no-op for now
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
        SidebarNavItem(
          item: const NavItemModel(
            route: NavRoute.settings,
            label: AppStrings.navSettings,
            iconCodepoint: 0,
          ),
          isActive: activeRoute == NavRoute.settings,
          isCollapsed: isCollapsed,
          onTap: () => ref
              .read(dashboardProvider.notifier)
              .selectNav(NavRoute.settings),
        ),
        SidebarNavItem(
          item: const NavItemModel(
            route: NavRoute.home,
            label: AppStrings.navLogout,
            iconCodepoint: 0,
          ),
          isActive: false,
          isCollapsed: isCollapsed,
          onTap: () {},
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}