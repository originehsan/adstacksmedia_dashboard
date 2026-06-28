import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../shared/widgets/app_scrollbar.dart';
import '../../../theme/app_spacing.dart';
import '../../../viewmodels/dashboard_provider.dart';
import '../right_panel/placeholder_content.dart';
import 'all_projects_section.dart';
import 'hero_project_card.dart';
import 'performance_chart_section.dart';
import 'top_creators_section.dart';

// Scrollable main content area
// Switches between HomeContent and PlaceholderContent based on activeRoute
class MainContentWidget extends ConsumerWidget {
  const MainContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeRoute = ref.watch(dashboardProvider).activeRoute;

    return Expanded(
      child: AppScrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: _buildContent(activeRoute),
        ),
      ),
    );
  }

  Widget _buildContent(dynamic activeRoute) {
    switch (activeRoute.name) {
      case 'home':
        return const _HomeContent();
      default:
        return PlaceholderContent(routeName: activeRoute.name);
    }
  }
}

// Home tab content — hero card + projects/creators row + chart
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Featured project hero card
        HeroProjectCard(),
        Gap(16),
        // Projects list and Top Creators side by side on wide screens
        _ProjectsAndCreatorsRow(),
        Gap(16),
        // Performance line chart
        PerformanceChartSection(),
        Gap(16),
      ],
    );
  }
}

// Responsive row — side by side on desktop, stacked on smaller screens
class _ProjectsAndCreatorsRow extends StatelessWidget {
  const _ProjectsAndCreatorsRow();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSideBySide = width > 900;

    if (isSideBySide) {
      return const IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: AllProjectsSection()),
            Gap(16),
            Expanded(child: TopCreatorsSection()),
          ],
        ),
      );
    }

    return const Column(
      children: [
        AllProjectsSection(),
        Gap(16),
        TopCreatorsSection(),
      ],
    );
  }
}