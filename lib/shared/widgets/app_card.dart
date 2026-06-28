import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

// Shared card container used by all dashboard sections
// hero card, projects, creators, chart, calendar, birthday, anniversary
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final double? width;
  final double? height;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.cardBg,
        borderRadius: borderRadius ?? AppRadius.lgAll,
        border: border ??
            Border.all(
              color: AppColors.border,
              width: 0.5,
            ),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}