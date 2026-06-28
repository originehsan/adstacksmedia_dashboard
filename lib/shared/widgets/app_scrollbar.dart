import 'package:flutter/material.dart';

// Scrollbar removed — Flutter Web handles scrollbars automatically
// Using Scrollbar widget without explicit ScrollController causes errors
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
    return child;
  }
}