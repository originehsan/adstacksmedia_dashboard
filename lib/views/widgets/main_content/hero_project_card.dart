import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_primary_button.dart';
import '../../../shared/widgets/geometric_shape_painter.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';

// Featured project hero card — full width of center area
// Dark navy gradient with large 3D geometric shapes on right
// Responsive — shapes hidden on very small screens
class HeroProjectCard extends StatelessWidget {
  const HeroProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 180),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.heroBgStart,
              Color(0xFF2D2F6B),
              AppColors.heroBgEnd,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Large geometric shapes filling right half
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final shapeWidth =
                      MediaQuery.of(context).size.width * 0.35;
                  return SizedBox(
                    width: shapeWidth.clamp(150.0, 400.0),
                    child: const CustomPaint(
                      painter: GeometricShapePainter(),
                    ),
                  );
                },
              ),
            ),
            // Card content — left aligned
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Project tag pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
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
                  const Gap(10),
                  // Hero title — bigger and bolder
                  Text(
                    AppStrings.heroTitle,
                    style: AppTypography.heroTitle.copyWith(
                      fontSize: 26,
                      height: 1.15,
                    ),
                  ),
                  const Gap(6),
                  // Hero subtitle
                  Text(
                    AppStrings.heroSubtitle,
                    style: AppTypography.heroSubtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(16),
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