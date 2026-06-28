import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../models/project_model.dart';
import '../../../shared/widgets/app_icon_button.dart';
import '../../../shared/widgets/app_status_chip.dart';
import '../../../shared/widgets/hover_builder.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';

// Single project row in All Projects section
// Shows thumbnail placeholder, title, project number, status chip, edit icon
class ProjectListItem extends StatelessWidget {
  final ProjectModel project;

  const ProjectListItem({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
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
                width: 42,
                height: 42,
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
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              const Gap(12),
              // Project title and number
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
                    Row(
                      children: [
                        Text(
                          '${AppStrings.projectPrefix}${project.projectNumber}',
                          style: AppTypography.caption,
                        ),
                        const Gap(4),
                        Text(
                          '· ${AppStrings.seeDetailsLabel}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(8),
              // Project status chip
              AppStatusChip(status: project.status),
              const Gap(8),
              // Edit icon button
              AppIconButton(
                icon: Icons.edit_outlined,
                tooltip: AppStrings.tooltipEditProject,
                iconColor: AppColors.textMuted,
                size: 28,
                iconSize: 15,
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}