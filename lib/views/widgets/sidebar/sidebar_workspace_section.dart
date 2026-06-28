import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../models/workspace_model.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../../../constants/app_strings.dart';
import '../../../viewmodels/dashboard_provider.dart';
import 'sidebar_workspace_item.dart';

// Workspaces section in sidebar below nav items
// Shows "WORKSPACES" header + add button + list of workspace groups
class SidebarWorkspaceSection extends ConsumerWidget {
  final List<WorkspaceModel> workspaces;

  const SidebarWorkspaceSection({
    super.key,
    required this.workspaces,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with add button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 12, 4),
          child: Row(
            children: [
              Text(
                AppStrings.workspacesLabel,
                style: AppTypography.workspaceLabel,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.add_rounded,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const Gap(4),
        // Workspace group items
        ...workspaces.map(
          (workspace) => SidebarWorkspaceItem(
            workspace: workspace,
            onToggle: () => ref
                .read(dashboardProvider.notifier)
                .toggleWorkspace(workspace.id),
          ),
        ),
      ],
    );
  }
}