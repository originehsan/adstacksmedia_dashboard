import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/app_icon_button.dart';
import '../../../shared/widgets/app_search_bar.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../../../viewmodels/dashboard_provider.dart';

// Top navigation bar spanning full width above main content and right panel
// Shows active route title, search bar, action icons, user avatar
class RightPanelNavbar extends ConsumerWidget {
  const RightPanelNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final user = state.currentUser;

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          // Active route title
          Text(
            AppStrings.panelHomeTitle,
            style: AppTypography.headingSm,
          ),
          const Gap(24),
          // Search bar — flex grows to fill available space
          Expanded(
            child: AppSearchBar(
              onChanged: (value) => ref
                  .read(dashboardProvider.notifier)
                  .updateSearchQuery(value),
            ),
          ),
          const Gap(16),
          // Action icon buttons
          AppIconButton(
            icon: Icons.grid_view_rounded,
            tooltip: AppStrings.tooltipGrid,
            onTap: () {},
          ),
          const Gap(8),
          AppIconButton(
            icon: Icons.notifications_none_rounded,
            tooltip: AppStrings.tooltipNotifications,
            onTap: () {},
          ),
          const Gap(8),
          AppIconButton(
            icon: Icons.access_time_rounded,
            tooltip: AppStrings.tooltipClock,
            onTap: () {},
          ),
          const Gap(12),
          // User avatar
          if (user != null)
            AppAvatar(
              colorHex: user.avatarColorHex,
              name: user.name,
              size: 32,
              fontSize: 11,
            ),
        ],
      ),
    );
  }
}