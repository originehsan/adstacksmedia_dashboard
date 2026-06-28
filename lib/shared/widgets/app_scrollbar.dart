import 'package:flutter/material.dart';
import '../../theme/app_radius.dart';

// Themed scrollbar wrapper for all scrollable areas in the dashboard
// Used by: main content area, right panel, sidebar workspace section
class AppScrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final bool isAlwaysShown;

  const AppScrollbar({
    super.key,
    required this.child,
    this.controller,
    this.isAlwaysShown = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      thumbVisibility: isAlwaysShown,
      thickness: 4,
      radius: const Radius.circular(AppRadius.lg),
      child: child,
    );
  }
}