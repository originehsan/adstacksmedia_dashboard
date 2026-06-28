import 'package:flutter/material.dart';
import '../theme/app_breakpoints.dart';
import '../theme/app_spacing.dart';

class ResponsiveHelper {
  ResponsiveHelper._();

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppBreakpoints.mobile;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppBreakpoints.mobile && width < AppBreakpoints.tablet;
  }

  static bool isDesktopSm(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppBreakpoints.tablet && width < AppBreakpoints.desktop;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppBreakpoints.desktop;
  }

  static bool isDesktopLg(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppBreakpoints.desktopLg;
  }

  static bool showRightPanel(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppBreakpoints.desktop;
  }

  static bool showFullSidebar(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppBreakpoints.tablet;
  }

  static bool showBottomNav(BuildContext context) {
    return MediaQuery.of(context).size.width < AppBreakpoints.mobile;
  }

  static double sidebarWidth(BuildContext context) {
    if (isMobile(context)) return 0;
    if (isTablet(context)) return AppSpacing.sidebarCollapsedWidth;
    return AppSpacing.sidebarWidth;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}