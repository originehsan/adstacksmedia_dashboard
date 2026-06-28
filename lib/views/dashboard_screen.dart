import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../constants/app_enums.dart';
import '../constants/app_strings.dart';
import '../extensions/context_extensions.dart';
import '../shared/widgets/app_avatar.dart';
import '../shared/widgets/app_icon_button.dart';
import '../shared/widgets/hover_builder.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../viewmodels/dashboard_provider.dart';
import 'widgets/main_content/main_content_widget.dart';
import 'widgets/right_panel/right_panel_navbar.dart';
import 'widgets/right_panel/right_panel_widget.dart';
import 'widgets/sidebar/sidebar_widget.dart';

// Responsive layout shell — zero business logic
// Mobile  < 600px  : Drawer + BottomNav + single column
// Tablet  601-900px: Auto-collapsed sidebar (64px) + main
// Desktop 901-1200px: Full sidebar + main + right panel overlay toggle
// Desktop > 1200px : Full 3-column layout — sidebar + main + right panel
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(dashboardProvider.notifier).initialize();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Auto collapse/expand sidebar on resize using responsive_framework
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final notifier = ref.read(dashboardProvider.notifier);
      final bp = ResponsiveBreakpoints.of(context);
      if (bp.equals(MOBILE)) {
        notifier.collapseSidebar();
      } else if (bp.equals(TABLET)) {
        notifier.collapseSidebar();
      } else {
        notifier.expandSidebar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);

    // Show loader until data is ready
    if (state.isLoading || state.currentUser == null) {
      return const Scaffold(
        backgroundColor: AppColors.pageBg,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2,
          ),
        ),
      );
    }

    // Show error state if initialization failed
    if (state.errorMessage != null) {
      return Scaffold(
        backgroundColor: AppColors.pageBg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: AppColors.danger,
              ),
              const Gap(16),
              Text(
                state.errorMessage!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(dashboardProvider.notifier).initialize(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (context.isMobile) return const _MobileLayout();
    if (context.isTablet) return const _TabletLayout();
    if (context.isDesktopSm) return const _DesktopSmLayout();
    return const _DesktopLayout();
  }
}

// ─── Mobile Layout < 600px ───────────────────────────────────────────────────
class _MobileLayout extends ConsumerWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.pageBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppSpacing.topBarHeight),
        child: Container(
          height: AppSpacing.topBarHeight,
          decoration: const BoxDecoration(
            color: AppColors.cardBg,
            border: Border(
              bottom: BorderSide(color: AppColors.border, width: 0.5),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              AppIconButton(
                icon: Icons.menu_rounded,
                onTap: () => scaffoldKey.currentState?.openDrawer(),
                tooltip: AppStrings.tooltipToggleSidebar,
              ),
              const Gap(8),
              Image.asset(
                'assets/images/logo.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
              const Gap(6),
              // App name hidden on very small screens
              if (context.screenWidth > 360)
                Text(
                  AppStrings.appName,
                  style: AppTypography.headingSm.copyWith(
                    color: AppColors.logoNavy,
                    fontSize: 14,
                  ),
                ),
              const Spacer(),
              AppIconButton(
                icon: Icons.search_rounded,
                onTap: () {},
                tooltip: AppStrings.searchHint,
                size: 28,
                iconSize: 16,
              ),
              AppIconButton(
                icon: Icons.notifications_none_rounded,
                onTap: () {},
                tooltip: AppStrings.tooltipNotifications,
                size: 28,
                iconSize: 16,
              ),
              const Gap(4),
              if (state.currentUser != null)
                AppAvatar(
                  colorHex: state.currentUser!.avatarColorHex,
                  name: state.currentUser!.name,
                  size: 28,
                  fontSize: 10,
                ),
            ],
          ),
        ),
      ),
      drawer: const Drawer(
        width: AppSpacing.sidebarWidth,
        backgroundColor: AppColors.sidebarBg,
        child: SidebarWidget(),
      ),
      body: const Row(children: [MainContentWidget()]),
      bottomNavigationBar: const _MobileBottomNav(),
    );
  }
}

// Mobile bottom navigation bar
class _MobileBottomNav extends ConsumerWidget {
  const _MobileBottomNav();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    if (state.bottomNavItems.isEmpty) return const SizedBox.shrink();

    final bottomNavRoutes = [
      NavRoute.home,
      NavRoute.employees,
      NavRoute.attendance,
      NavRoute.settings,
    ];

    final currentIndex = bottomNavRoutes
        .indexOf(state.activeRoute)
        .clamp(0, bottomNavRoutes.length - 1);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.cardBg,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          if (index < bottomNavRoutes.length) {
            ref
                .read(dashboardProvider.notifier)
                .selectNav(bottomNavRoutes[index]);
          }
        },
        items: bottomNavRoutes.map((route) {
          return BottomNavigationBarItem(
            icon: Icon(_iconFromRoute(route), size: 20),
            label: _labelFromRoute(route),
          );
        }).toList(),
      ),
    );
  }

  String _labelFromRoute(NavRoute route) {
    switch (route) {
      case NavRoute.home:
        return AppStrings.navHome;
      case NavRoute.employees:
        return AppStrings.navEmployees;
      case NavRoute.attendance:
        return AppStrings.navAttendance;
      case NavRoute.settings:
        return AppStrings.navSettings;
      default:
        return '';
    }
  }

  IconData _iconFromRoute(NavRoute route) {
    switch (route) {
      case NavRoute.home:
        return Icons.home_rounded;
      case NavRoute.employees:
        return Icons.people_alt_rounded;
      case NavRoute.attendance:
        return Icons.access_time_rounded;
      case NavRoute.settings:
        return Icons.settings_outlined;
      default:
        return Icons.circle;
    }
  }
}

// ─── Tablet Layout 601-900px ──────────────────────────────────────────────────
class _TabletLayout extends ConsumerWidget {
  const _TabletLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(dashboardProvider);
      if (!state.isSidebarCollapsed) {
        ref.read(dashboardProvider.notifier).collapseSidebar();
      }
    });

    return const Scaffold(
      backgroundColor: AppColors.pageBg,
      body: Column(
        children: [
          RightPanelNavbar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SidebarWidget(),
                MainContentWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Desktop Small Layout 901-1200px ─────────────────────────────────────────
class _DesktopSmLayout extends ConsumerWidget {
  const _DesktopSmLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.isSidebarCollapsed) {
        ref.read(dashboardProvider.notifier).expandSidebar();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: Stack(
        children: [
          Column(
            children: [
              _DesktopSmNavbar(),
              const Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SidebarWidget(),
                    MainContentWidget(),
                  ],
                ),
              ),
            ],
          ),
          // Right panel slides in as overlay
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            top: 0,
            right: state.isRightPanelVisible
                ? 0
                : -AppSpacing.rightPanelWidth,
            bottom: 0,
            child: const RightPanelWidget(),
          ),
        ],
      ),
    );
  }
}

// Desktop small navbar with right panel toggle
class _DesktopSmNavbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(dashboardProvider).isRightPanelVisible;

    return Container(
      height: AppSpacing.topBarHeight,
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Expanded(child: RightPanelNavbar()),
          const Gap(8),
          // Toggle right panel overlay button
          HoverBuilder(
            builder: (isHovered) {
              return GestureDetector(
                onTap: () =>
                    ref.read(dashboardProvider.notifier).toggleRightPanel(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isVisible
                        ? AppColors.primaryLight
                        : isHovered
                            ? AppColors.borderLight
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isVisible
                          ? AppColors.primary
                          : AppColors.border,
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isVisible
                            ? Icons.close_rounded
                            : Icons.view_sidebar_outlined,
                        size: 14,
                        color: isVisible
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                      const Gap(4),
                      Text(
                        isVisible ? 'Hide Panel' : 'Show Panel',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isVisible
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Full Desktop Layout > 1200px ────────────────────────────────────────────
class _DesktopLayout extends ConsumerWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.isSidebarCollapsed) {
        ref.read(dashboardProvider.notifier).expandSidebar();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: Column(
        children: [
          _DesktopNavbar(),
          const Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SidebarWidget(),
                MainContentWidget(),
                RightPanelWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Full desktop navbar with sidebar collapse toggle
class _DesktopNavbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCollapsed = ref.watch(dashboardProvider).isSidebarCollapsed;

    return Container(
      height: AppSpacing.topBarHeight,
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          AppIconButton(
            icon: isCollapsed
                ? Icons.menu_rounded
                : Icons.menu_open_rounded,
            tooltip: AppStrings.tooltipToggleSidebar,
            onTap: () =>
                ref.read(dashboardProvider.notifier).toggleSidebar(),
          ),
          const Gap(8),
          const Expanded(child: RightPanelNavbar()),
        ],
      ),
    );
  }
}