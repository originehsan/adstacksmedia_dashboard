import 'package:equatable/equatable.dart';
import '../constants/app_enums.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final UserRole role;
  final int avatarColorHex;

  const UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarColorHex,
  });

  String get roleLabel {
    switch (role) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.user:
        return 'User';
      case UserRole.viewer:
        return 'Viewer';
    }
  }

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  UserModel copyWith({
    String? id,
    String? name,
    UserRole? role,
    int? avatarColorHex,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      avatarColorHex: avatarColorHex ?? this.avatarColorHex,
    );
  }

  @override
  List<Object?> get props => [id, name, role, avatarColorHex];
}