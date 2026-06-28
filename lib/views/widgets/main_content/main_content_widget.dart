import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_enums.dart';
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
          // AnimatedSwitcher adds fade transition when switching nav routes
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.02, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: KeyedSubtree(
              key: ValueKey(activeRoute),
              child: _buildContent(activeRoute),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(NavRoute activeRoute) {
    switch (activeRoute) {
      case NavRoute.home:
        return const _HomeContent();
      case NavRoute.employees:
        return const PlaceholderContent(routeName: 'employees');
      case NavRoute.attendance:
        return const PlaceholderContent(routeName: 'attendance');
      case NavRoute.summary:
        return const PlaceholderContent(routeName: 'summary');
      case NavRoute.information:
        return const PlaceholderContent(routeName: 'information');
      case NavRoute.settings:
        return const PlaceholderContent(routeName: 'settings');
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
// IntrinsicHeight removed — conflicts with LayoutBuilder inside AppRatingBar
class _ProjectsAndCreatorsRow extends StatelessWidget {
  const _ProjectsAndCreatorsRow();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSideBySide = width > 900;

    if (isSideBySide) {
      return const  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Expanded(child: AllProjectsSection()),
          Gap(16),
          Expanded(child: TopCreatorsSection()),
        ],
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