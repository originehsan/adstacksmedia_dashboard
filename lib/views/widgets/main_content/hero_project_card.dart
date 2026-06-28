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
// Fixed height removed — uses mainAxisSize.min to prevent overflow
// Geometric shapes clipped to card bounds on small screens
class HeroProjectCard extends StatelessWidget {
  const HeroProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.heroBgStart, AppColors.heroBgEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Stack(
          children: [
            // Floating 3D geometric shapes — clipped by ClipRRect
            const Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: 200,
                child: CustomPaint(
                  painter: GeometricShapePainter(),
                ),
              ),
            ),
            // Card content — no fixed height, grows with content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                  // Hero subtitle — ellipsis on very small screens
                  Text(
                    AppStrings.heroSubtitle,
                    style: AppTypography.heroSubtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(12),
                  // CTA button
                  AppPrimaryButton(
                    label: AppStrings.heroCtaLabel,
                    backgroundColor: Colors.white,
                    textColor: AppColors.heroBgStart,
                    onPressed: () {},
                  ),
                  const Gap(4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}