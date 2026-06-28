import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension BuildContextExtensions on BuildContext {
  // Screen size
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // Breakpoints — now using responsive_framework
  // Single source of truth for all layout decisions
  bool get isMobile =>
      ResponsiveBreakpoints.of(this).equals(MOBILE);

  bool get isTablet =>
      ResponsiveBreakpoints.of(this).equals(TABLET);

  bool get isDesktopSm =>
      ResponsiveBreakpoints.of(this).equals(DESKTOP);

  bool get isDesktop =>
      ResponsiveBreakpoints.of(this).equals(DESKTOP) ||
      ResponsiveBreakpoints.of(this).equals('4K');

  bool get isDesktopLg =>
      ResponsiveBreakpoints.of(this).equals('4K');

  // Show/hide panels based on breakpoint
  // Right panel only on full desktop (>1200px)
  bool get showRightPanel =>
      ResponsiveBreakpoints.of(this).equals('4K');

  // Full sidebar on tablet and above
  bool get showFullSidebar =>
      !ResponsiveBreakpoints.of(this).equals(MOBILE);

  // Bottom nav only on mobile
  bool get showBottomNav =>
      ResponsiveBreakpoints.of(this).equals(MOBILE);

  // Larger than mobile
  bool get isLargerThanMobile =>
      ResponsiveBreakpoints.of(this).largerThan(MOBILE);

  // Larger than tablet
  bool get isLargerThanTablet =>
      ResponsiveBreakpoints.of(this).largerThan(TABLET);

  // Theme shortcuts
  ThemeData get appTheme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Padding
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
}