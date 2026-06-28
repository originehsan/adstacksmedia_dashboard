import 'package:flutter/material.dart';
import '../../constants/app_enums.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

// Colored status chip for ProjectStatus enum
// Used in project list items to show pending/inProgress/done state
class AppStatusChip extends StatelessWidget {
  final ProjectStatus status;

  const AppStatusChip({
    super.key,
    required this.status,
  });

  // Background color per status
  Color get _backgroundColor {
    switch (status) {
      case ProjectStatus.pending:
        return AppColors.warningLight;
      case ProjectStatus.inProgress:
        return AppColors.primaryLight;
      case ProjectStatus.done:
        return AppColors.successLight;
    }
  }

  // Text color per status
  Color get _textColor {
    switch (status) {
      case ProjectStatus.pending:
        return AppColors.warning;
      case ProjectStatus.inProgress:
        return AppColors.primary;
      case ProjectStatus.done:
        return AppColors.success;
    }
  }

  // Label per status
  String get _label {
    switch (status) {
      case ProjectStatus.pending:
        return 'Pending';
      case ProjectStatus.inProgress:
        return 'In Progress';
      case ProjectStatus.done:
        return 'Done';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _textColor,
        ),
      ),
    );
  }
}