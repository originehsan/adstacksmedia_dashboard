import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'constants/app_strings.dart';
import 'theme/app_theme.dart';
import 'utils/scroll_behavior_web.dart';
import 'views/dashboard_screen.dart';

// Root app widget — configures MaterialApp, theme, scroll behavior
// ProviderScope is set in main.dart wrapping this widget
class AdstacksApp extends ConsumerWidget {
  const AdstacksApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // Light theme using our design tokens
      theme: AppTheme.light,

      // Enables mouse drag scrolling on Flutter Web
      scrollBehavior: const WebScrollBehavior(),

      // ResponsiveBreakpoints wraps the entire app
      // Defines breakpoints used by ResponsiveBreakpoints.of(context)
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          // Mobile — single column, drawer, bottom nav
          const Breakpoint(start: 0, end: 600, name: MOBILE),
          // Tablet — collapsed sidebar, no right panel
          const Breakpoint(start: 601, end: 900, name: TABLET),
          // Desktop small — full sidebar, right panel as overlay
          const Breakpoint(start: 901, end: 1200, name: DESKTOP),
          // Desktop large — full 3 column layout
          const Breakpoint(start: 1201, end: double.infinity, name: '4K'),
        ],
      ),

      home: const DashboardScreen(),
    );
  }
}