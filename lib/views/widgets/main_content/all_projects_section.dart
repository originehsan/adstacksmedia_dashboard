import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_section_header.dart';
import '../../../constants/app_strings.dart';
import '../../../viewmodels/dashboard_provider.dart';
import 'project_list_item.dart';

// All Projects section card in main content area
// Shows section header + list of 3 project rows
class AllProjectsSection extends ConsumerWidget {
  const AllProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(dashboardProvider).projects;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(
            title: AppStrings.allProjectsTitle,
          ),
          const Gap(12),
          ...projects.map(
            (project) => ProjectListItem(project: project),
          ),
        ],
      ),
    );
  }
}