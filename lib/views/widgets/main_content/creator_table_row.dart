import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../models/creator_model.dart';
import '../../../shared/widgets/app_avatar.dart';
import '../../../shared/widgets/app_rating_bar.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

// Single creator row in Top Creators table
// showArtworks hidden on mobile to prevent overflow
class CreatorTableRow extends StatelessWidget {
  final CreatorModel creator;
  final bool showArtworks;

  const CreatorTableRow({
    super.key,
    required this.creator,
    this.showArtworks = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          // Avatar + handle name — flexible to prevent overflow
          Expanded(
            flex: 3,
            child: Row(
              children: [
                AppAvatar(
                  colorHex: creator.avatarColorHex,
                  name: creator.name,
                  size: 26,
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
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          // Artworks count — hidden on mobile
          if (showArtworks)
            SizedBox(
              width: 65,
              child: Text(
                creator.artworksCount.toString(),
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          // Rating bar
          Expanded(
            flex: 2,
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