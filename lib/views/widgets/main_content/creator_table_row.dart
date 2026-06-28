import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../models/creator_model.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/app_rating_bar.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

// Single creator row in Top Creators table
// Shows avatar, handle, artworks count, colored rating bar
class CreatorTableRow extends StatelessWidget {
  final CreatorModel creator;

  const CreatorTableRow({
    super.key,
    required this.creator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          // Avatar + handle name
          SizedBox(
            width: 140,
            child: Row(
              children: [
                AppAvatar(
                  colorHex: creator.avatarColorHex,
                  name: creator.name,
                  size: 28,
                  fontSize: 10,
                ),
                const Gap(6),
                Expanded(
                  child: Text(
                    creator.handle,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Artworks count
          SizedBox(
            width: 70,
            child: Text(
              creator.artworksCount.toString(),
              style: AppTypography.bodySm.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          // Colored rating bar — color matches avatar color
          Expanded(
            child: AppRatingBar(
              value: creator.rating,
              height: 5,
              fillColor: Color(creator.avatarColorHex),
            ),
          ),
        ],
      ),
    );
  }
}