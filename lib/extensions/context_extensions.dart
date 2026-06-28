import 'package:flutter/material.dart';
import '../theme/app_breakpoints.dart';

extension BuildContextExtensions on BuildContext {
  // Screen size
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // Breakpoints
  bool get isMobile => screenWidth < AppBreakpoints.mobile;
  bool get isTablet =>
      screenWidth >= AppBreakpoints.mobile &&
      screenWidth < AppBreakpoints.tablet;
  bool get isDesktopSm =>
      screenWidth >= AppBreakpoints.tablet &&
      screenWidth < AppBreakpoints.desktop;
  bool get isDesktop => screenWidth >= AppBreakpoints.desktop;
  bool get isDesktopLg => screenWidth >= AppBreakpoints.desktopLg;

  // Show/hide panels
  bool get showRightPanel => screenWidth >= AppBreakpoints.desktop;
  bool get showFullSidebar => screenWidth >= AppBreakpoints.tablet;
  bool get showBottomNav => screenWidth < AppBreakpoints.mobile;

  // Theme shortcuts
  ThemeData get appTheme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Padding
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
}