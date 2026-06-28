import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_section_header.dart';
import '../../../theme/app_colors.dart';
import '../../../viewmodels/dashboard_provider.dart';
import 'project_list_item.dart';

// All Projects section card in main content area
// Shows section header + list of 3 project rows
class AllProjectsSection extends ConsumerWidget {
  const AllProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    // select() prevents rebuild on unrelated state changes
    // e.g. sidebar toggle, calendar selection, search query
    final projects = ref.watch(
      dashboardProvider.select((s) => s.projects),
    );

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(title: AppStrings.allProjectsTitle),
          const Gap(12),
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
          else if (projects.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open_rounded,
                      size: 40,
                      color: AppColors.textMuted,
                    ),
                    Gap(8),
                    Text(
                      'No projects yet',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            )
          // Projects list
          else
            ...projects.map(
              (project) => ProjectListItem(project: project),
            ),
        ],
      ),
    );
  }
}