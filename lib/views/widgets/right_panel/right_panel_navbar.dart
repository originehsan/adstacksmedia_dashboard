import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/app_icon_button.dart';
import '../../../shared/widgets/app_search_bar.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../../../viewmodels/dashboard_provider.dart';

// Top navigation bar — fully responsive
// Tablet: hides title and some icons to save space
// Desktop: full layout with title, search, icons, avatar
class RightPanelNavbar extends ConsumerWidget {
  const RightPanelNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final user = state.currentUser;
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);
    final isTablet = ResponsiveBreakpoints.of(context).equals(TABLET);
    final isCompact = isMobile || isTablet;

    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 12 : 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Title — hidden on tablet to save space
          if (!isTablet) ...[
            Text(
              AppStrings.panelHomeTitle,
              style: AppTypography.headingSm,
            ),
            Gap(isCompact ? 12 : 24),
          ],
          // Search bar — always visible, grows to fill space
          Expanded(
            child: AppSearchBar(
              onChanged: (value) => ref
                  .read(dashboardProvider.notifier)
                  .updateSearchQuery(value),
            ),
          ),
          Gap(isCompact ? 8 : 16),
          // Grid icon — hidden on tablet
          if (!isTablet)
            AppIconButton(
              icon: Icons.grid_view_rounded,
              tooltip: AppStrings.tooltipGrid,
              onTap: () {},
              size: isCompact ? 28 : 32,
              iconSize: isCompact ? 16 : 18,
            ),
          Gap(isCompact ? 4 : 8),
          // Notification icon — always visible
          AppIconButton(
            icon: Icons.notifications_none_rounded,
            tooltip: AppStrings.tooltipNotifications,
            onTap: () {},
            size: isCompact ? 28 : 32,
            iconSize: isCompact ? 16 : 18,
          ),
          Gap(isCompact ? 4 : 8),
          // Clock icon — hidden on tablet
          if (!isTablet)
            AppIconButton(
              icon: Icons.access_time_rounded,
              tooltip: AppStrings.tooltipClock,
              onTap: () {},
              size: isCompact ? 28 : 32,
              iconSize: isCompact ? 16 : 18,
            ),
          Gap(isCompact ? 6 : 12),
          // User avatar — always visible
          if (user != null)
            AppAvatar(
              colorHex: user.avatarColorHex,
              name: user.name,
              size: isCompact ? 28 : 32,
              fontSize: 10,
            ),
        ],
      ),
    );
  }
}