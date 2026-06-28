import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_section_header.dart';
import '../../../theme/app_colors.dart';
import '../../../viewmodels/dashboard_provider.dart';
import 'creator_table_row.dart';

// Top Creators section card in main content area
// Uses LayoutBuilder to decide artworks column visibility
// based on available card width — not just screen breakpoint
class TopCreatorsSection extends ConsumerWidget {
  const TopCreatorsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final creators = state.topCreators;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Show artworks column only when card is wide enough
          final showArtworks = constraints.maxWidth > 280;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSectionHeader(
                title: AppStrings.topCreatorsTitle,
              ),
              const Gap(8),
              // Table column headers
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    // Name column
                    const Expanded(
                      flex: 3,
                      child: Text(
                        AppStrings.colName,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                    // Artworks — only when enough space
                    if (showArtworks)
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
                        textAlign: showArtworks
                            ? TextAlign.left
                            : TextAlign.right,
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
                    showArtworks: showArtworks,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}