import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../constants/app_strings.dart';
import '../../../models/project_model.dart';
import '../../../shared/widgets/app_icon_button.dart';
import '../../../shared/widgets/app_status_chip.dart';
import '../../../shared/widgets/hover_builder.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';

// Single project row — fully responsive
// Mobile: hides status chip label, shows only icon
// Desktop: full row with thumbnail, title, status chip, edit icon
class ProjectListItem extends StatelessWidget {
  final ProjectModel project;

  const ProjectListItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);

    return HoverBuilder(
      builder: (isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isHovered ? AppColors.borderLight : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              // Project thumbnail placeholder
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withAlpha(60),
                      AppColors.heroBgEnd.withAlpha(40),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(
                  Icons.image_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const Gap(10),
              // Project title and number — Expanded prevents overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: AppTypography.labelMd.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(2),
                    // On mobile show only project number
                    // On desktop show full details link
                    if (isMobile)
                      Text(
                        '${AppStrings.projectPrefix}${project.projectNumber}',
                        style: AppTypography.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    else
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${AppStrings.projectPrefix}${project.projectNumber} · ${AppStrings.seeDetailsLabel}',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const Gap(6),
              // Status chip — hidden on mobile to save space
              if (!isMobile) ...[
                AppStatusChip(status: project.status),
                const Gap(6),
              ],
              // Edit icon
              AppIconButton(
                icon: Icons.edit_outlined,
                tooltip: AppStrings.tooltipEditProject,
                iconColor: AppColors.textMuted,
                size: 26,
                iconSize: 14,
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
