import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_section_header.dart';
import '../../../theme/app_colors.dart';
import '../../../viewmodels/dashboard_provider.dart';
import 'creator_table_row.dart';

// Top Creators section card in main content area
// Responsive table — artworks column hidden on mobile to prevent overflow
class TopCreatorsSection extends ConsumerWidget {
  const TopCreatorsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final creators = state.topCreators;
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(
            title: AppStrings.topCreatorsTitle,
          ),
          const Gap(8),
          // Table column headers — artworks hidden on mobile
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                // Name column — flexible to prevent overflow
             const   Expanded(
                  flex: 3,
                  child: Text(
                    AppStrings.colName,
                    style:  TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ),
                // Artworks — hidden on mobile
                if (!isMobile)
                  const SizedBox(
                    width: 65,
                    child: Text(
                      AppStrings.colArtworks,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                // Rating column
                Expanded(
                  flex: 2,
                  child: Text(
                    AppStrings.colRating,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9CA3AF),
                    ),
                    textAlign: isMobile ? TextAlign.right : TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 0.5),
          const Gap(4),
          // Loading state
          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
            )
          // Empty state
          else if (creators.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline_rounded,
                      size: 40,
                      color: AppColors.textMuted,
                    ),
                    Gap(8),
                    Text(
                      'No creators yet',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            )
          // Creator rows
          else
            ...creators.map(
              (creator) => CreatorTableRow(
                creator: creator,
                showArtworks: !isMobile,
              ),
            ),
        ],
      ),
    );
  }
}