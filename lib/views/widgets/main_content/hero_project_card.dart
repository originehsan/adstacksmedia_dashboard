import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_primary_button.dart';
import '../../../shared/widgets/geometric_shape_painter.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';

// Featured project hero card at top of main content area
// Dark navy gradient background with floating geometric shapes
// Shows project tag, title, subtitle and Learn More CTA
class HeroProjectCard extends StatelessWidget {
  const HeroProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.heroBgStart, AppColors.heroBgEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Stack(
        children: [
          // Floating 3D geometric shapes — top right decoration
        const  Positioned(
            right: 0,
            top: 0,
            child: SizedBox(
              width: 220,
              height: 190,
              child: CustomPaint(
                painter:  GeometricShapePainter(),
              ),
            ),
          ),
          // Card content — left aligned
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project tag pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(38),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    AppStrings.heroTag,
                    style: AppTypography.heroTag,
                  ),
                ),
                const Gap(8),
                // Hero title
                Text(
                  AppStrings.heroTitle,
                  style: AppTypography.heroTitle,
                ),
                const Gap(4),
                // Hero subtitle
                Text(
                  AppStrings.heroSubtitle,
                  style: AppTypography.heroSubtitle,
                ),
                const Gap(12),
                // CTA button
                AppPrimaryButton(
                  label: AppStrings.heroCtaLabel,
                  backgroundColor: Colors.white,
                  textColor: AppColors.heroBgStart,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}