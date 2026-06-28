import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/app_scrollbar.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../viewmodels/dashboard_provider.dart';
import 'sidebar_bottom_actions.dart';
import 'sidebar_logo.dart';
import 'sidebar_nav_item.dart';
import 'sidebar_user_profile.dart';
import 'sidebar_workspace_section.dart';

// Full sidebar container — composes all sidebar sub-widgets
// isCollapsed toggles between 240px full and 64px icon-only mode
class SidebarWidget extends ConsumerWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final isCollapsed = state.isSidebarCollapsed;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      width: isCollapsed
          ? AppSpacing.sidebarCollapsedWidth
          : AppSpacing.sidebarWidth,
      decoration: const BoxDecoration(
        color: AppColors.sidebarBg,
        border: Border(
          right: BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo
          SidebarLogo(isCollapsed: isCollapsed),
          const Divider(height: 1, thickness: 0.5),
          // User profile
          SidebarUserProfile(
            user: state.currentUser!,
            isCollapsed: isCollapsed,
          ),
          const Divider(height: 1, thickness: 0.5),
          const SizedBox(height: 8),
          // Nav items — scrollable in case of overflow
          Expanded(
            child: AppScrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Primary nav items
                    ...state.primaryNavItems.map(
                      (item) => SidebarNavItem(
                        item: item,
                        isActive: state.activeRoute == item.route,
                        isCollapsed: isCollapsed,
                        onTap: () => ref
                            .read(dashboardProvider.notifier)
                            .selectNav(item.route),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Workspaces section — hidden when collapsed
                    if (!isCollapsed)
                      SidebarWorkspaceSection(
                        workspaces: state.workspaces,
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Settings + Logout pinned to bottom
          SidebarBottomActions(
            isCollapsed: isCollapsed,
            activeRoute: state.activeRoute,
          ),
        ],
      ),
    );
  }
}