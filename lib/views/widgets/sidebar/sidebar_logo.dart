import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/asset_paths.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';

// Adstacks Media logo shown at top of sidebar
// Uses SVG for crisp rendering at all sizes
// Full mode: logo + app name + tagline
// Collapsed mode: logo only in styled container
class SidebarLogo extends StatelessWidget {
  final bool isCollapsed;

  const SidebarLogo({super.key, required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? 12 : 16,
        vertical: 16,
      ),
      child: isCollapsed ? _collapsedLogo() : _fullLogo(),
    );
  }

  // Icon-only logo for collapsed sidebar (64px wide)
  Widget _collapsedLogo() {
    return const Center(
      child: _LogoContainer(size: 38),
    );
  }

  // Full logo with image + app name + tagline
  Widget _fullLogo() {
    return Row(
      children: [
       const  _LogoContainer(size: 44),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.appName,
                style: AppTypography.headingSm.copyWith(
                  color: AppColors.logoNavy,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w700,
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

// Logo container with light background for visibility
// SVG renders crisply at any size
class _LogoContainer extends StatelessWidget {
  final double size;

  const _LogoContainer({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: AppColors.border,
          width: 0.5,
        ),
        boxShadow:const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(3),
      child: SvgPicture.asset(
        AssetPaths.logo,
        fit: BoxFit.contain,
      ),
    );
  }
}