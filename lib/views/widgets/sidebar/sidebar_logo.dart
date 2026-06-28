import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/asset_paths.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

// Adstacks Media logo shown at top of sidebar
// Full mode: logo image + "Adstacks" text side by side
// Collapsed mode: logo image only scaled down
class SidebarLogo extends StatelessWidget {
  final bool isCollapsed;

  const SidebarLogo({
    super.key,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? 12 : 16,
        vertical: 20,
      ),
      child: isCollapsed ? _collapsedLogo() : _fullLogo(),
    );
  }

  // Icon-only logo for collapsed sidebar (64px wide)
  Widget _collapsedLogo() {
    return Center(
      child: Image.asset(
        AssetPaths.logo,
        width: 36,
        height: 36,
        fit: BoxFit.contain,
      ),
    );
  }

  // Full logo with image + app name text
  Widget _fullLogo() {
    return Row(
      children: [
        Image.asset(
          AssetPaths.logo,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.appName,
              style: AppTypography.headingSm.copyWith(
                color: AppColors.logoNavy,
                letterSpacing: 0.2,
              ),
            ),
            Text(
              AppStrings.appTagline,
              style: AppTypography.labelSm.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}