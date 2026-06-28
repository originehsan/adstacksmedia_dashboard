import 'package:equatable/equatable.dart';

// Top Creators table row in the dashboard main content area
class CreatorModel extends Equatable {
  final String id;
  final String name;
  final String handle; // @username shown in table
  final int artworksCount; // shown in Artworks column
  final double rating; // 0.0 to 1.0 — drives the rating bar width
  final int avatarColorHex; // ARGB int — converted to Color in view layer

  const CreatorModel({
    required this.id,
    required this.name,
    required this.handle,
    required this.artworksCount,
    required this.rating,
    required this.avatarColorHex,
  });

  CreatorModel copyWith({
    String? id,
    String? name,
    String? handle,
    int? artworksCount,
    double? rating,
    int? avatarColorHex,
  }) {
    return CreatorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      handle: handle ?? this.handle,
      artworksCount: artworksCount ?? this.artworksCount,
      rating: rating ?? this.rating,
      avatarColorHex: avatarColorHex ?? this.avatarColorHex,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        handle,
        artworksCount,
        rating,
        avatarColorHex,
      ];
}