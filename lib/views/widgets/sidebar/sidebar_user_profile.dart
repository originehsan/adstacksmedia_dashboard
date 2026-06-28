import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../models/user_model.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/app_badge.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

// User profile section in sidebar below logo
// Full mode: large avatar + name + role badge stacked vertically
// Collapsed mode: small avatar only centered
class SidebarUserProfile extends StatelessWidget {
  final UserModel user;
  final bool isCollapsed;

  const SidebarUserProfile({
    super.key,
    required this.user,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: isCollapsed ? _collapsedProfile() : _fullProfile(),
    );
  }

  // Avatar only for collapsed sidebar
  Widget _collapsedProfile() {
    return Center(
      child: AppAvatar(
        colorHex: user.avatarColorHex,
        name: user.name,
        size: 36,
      ),
    );
  }

  // Full profile with avatar, name and role badge
  Widget _fullProfile() {
    return Column(
      children: [
        AppAvatar(
          colorHex: user.avatarColorHex,
          name: user.name,
          size: 56,
          fontSize: 20,
        ),
        const Gap(8),
        Text(
          user.name,
          style: AppTypography.labelLg.copyWith(
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(4),
        AppBadge(
          label: user.roleLabel,
          backgroundColor: AppColors.primaryLight,
          textColor: AppColors.primary,
        ),
      ],
    );
  }
}