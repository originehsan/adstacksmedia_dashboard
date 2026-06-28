import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

// Shown when user clicks non-Home nav items (Employees, Attendance, etc.)
// Prevents empty screen — signals feature is planned but not built yet
class PlaceholderContent extends StatelessWidget {
  final String routeName;

  const PlaceholderContent({
    super.key,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.construction_rounded,
                size: 36,
                color: AppColors.primary,
              ),
            ),
            const Gap(20),
            Text(
              AppStrings.comingSoon,
              style: AppTypography.headingMd,
            ),
            const Gap(8),
            Text(
              AppStrings.featureInProgress,
              style: AppTypography.bodyMd,
              textAlign: TextAlign.center,
            ),
            const Gap(12),
            // Shows which route was clicked
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                routeName.toUpperCase(),
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}