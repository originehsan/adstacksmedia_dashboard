import 'package:flutter/material.dart';
import '../../../models/workspace_model.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

// Single workspace group row with expand/collapse chevron
// Shows folder icon + workspace name + animated chevron
class SidebarWorkspaceItem extends StatelessWidget {
  final WorkspaceModel workspace;
  final VoidCallback onToggle;

  const SidebarWorkspaceItem({
    super.key,
    required this.workspace,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Workspace header row
        GestureDetector(
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: Row(
              children: [
                Icon(
                  workspace.isExpanded
                      ? Icons.folder_open_rounded
                      : Icons.folder_rounded,
                  size: 15,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    workspace.name,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                // Animated chevron rotates when expanded
                AnimatedRotation(
                  turns: workspace.isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 15,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Children shown when workspace is expanded
        if (workspace.isExpanded)
          ...workspace.children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(
                left: 36,
                bottom: 4,
              ),
              child: Text(
                child,
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
      ],
    );
  }
}