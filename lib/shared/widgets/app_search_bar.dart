import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../constants/app_strings.dart';

// Search bar used in right panel top navbar
// Stateless — search query managed by DashboardViewModel.updateSearchQuery()
class AppSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final double? width;
  final double height;

  const AppSearchBar({
    super.key,
    this.onChanged,
    this.onTap,
    this.width,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: AppRadius.mdAll,
        border: Border.all(
          color: AppColors.border,
          width: 0.5,
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        onTap: onTap,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.textPrimary,
        ),
        decoration: const InputDecoration(
          hintText: AppStrings.searchHint,
          hintStyle: TextStyle(
            fontSize: 13,
            color: AppColors.textMuted,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 16,
            color: AppColors.textMuted,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
          ),
        ),
      ),
    );
  }
}