import 'package:flutter/material.dart';
import 'app_avatar.dart';

// Overlapping circular avatars — used in birthday and anniversary cards
// overlap controls how much each avatar slides under the previous one
class AvatarStack extends StatelessWidget {
  final List<int> colorHexList; // ARGB int list from model
  final List<String> names;
  final double size;
  final double overlap;
  final int maxVisible; // caps how many avatars show before +N badge

  const AvatarStack({
    super.key,
    required this.colorHexList,
    required this.names,
    this.size = 32,
    this.overlap = 10,
    this.maxVisible = 4,
  });

 @override
  Widget build(BuildContext context) {
    final count = colorHexList.length;

    // Guard against empty list — used by birthday and anniversary cards
    if (count == 0) {
      return SizedBox(
        width: size,
        height: size,
        child: Container(
          decoration: const BoxDecoration(
            color:  Color(0xFFE5E7EB),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            size: 16,
            color: Color(0xFF9CA3AF),
          ),
        ),
      );
    }

    // Use take() — safe on lists smaller than maxVisible
    final visibleCount = count > maxVisible ? maxVisible : count;
    final totalWidth = size + (visibleCount - 1) * (size - overlap);

    return SizedBox(
      width: totalWidth,
      height: size,
      child: Stack(
        children: List.generate(visibleCount, (i) {
          return Positioned(
            left: i * (size - overlap),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // White border between overlapping avatars
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: AppAvatar(
                colorHex: colorHexList[i],
                name: names[i],
                size: size,
                fontSize: size * 0.32,
              ),
            ),
          );
        }),
      ),
    );
  }
}