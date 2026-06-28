import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

// Styled tooltip wrapper with correct colors and delay
// Used by: app_icon_button, any widget needing a hover tooltip
class AppTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final Duration waitDuration;

  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.waitDuration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      waitDuration: waitDuration,
      decoration:const  BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: AppRadius.smAll,
      ),
      textStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: child,
    );
  }
}