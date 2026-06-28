import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

      // Single screen app — navigation handled inside DashboardScreen
      // via activeRoute state in DashboardViewModel
      home: const DashboardScreen(),
    );
  }
}