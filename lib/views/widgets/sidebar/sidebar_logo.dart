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

  const SidebarLogo({super.key, required this.isCollapsed});

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

  Widget _fullLogo() {
    return Row(
      children: [
        Image.asset(
          AssetPaths.logo,
          width: 36,
          height: 36,
          fit: BoxFit.contain,
        ),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.appName,
                style: AppTypography.headingSm.copyWith(
                  color: AppColors.logoNavy,
                  letterSpacing: 0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                AppStrings.appTagline,
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.textMuted,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
