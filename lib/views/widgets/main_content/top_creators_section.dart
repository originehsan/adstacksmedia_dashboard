import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_section_header.dart';
import '../../../viewmodels/dashboard_provider.dart';
import 'creator_table_row.dart';

// Top Creators section card in main content area
// Shows section header + table headers + creator rows
class TopCreatorsSection extends ConsumerWidget {
  const TopCreatorsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creators = ref.watch(dashboardProvider).topCreators;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(
            title: AppStrings.topCreatorsTitle,
          ),
          const Gap(8),
          // Table column headers
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  child: Text(
                    AppStrings.colName,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    AppStrings.colArtworks,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    AppStrings.colRating,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 0.5),
          const Gap(4),
          // Creator rows
          ...creators.map(
            (creator) => CreatorTableRow(creator: creator),
          ),
        ],
      ),
    );
  }
}