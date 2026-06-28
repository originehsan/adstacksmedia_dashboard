import 'package:equatable/equatable.dart';
import '../constants/app_enums.dart';

// Sidebar and bottom nav item
// iconCodepoint stored as int to keep model Flutter-free
// view layer reconstructs IconData(item.iconCodepoint, fontFamily: 'MaterialIcons')
class NavItemModel extends Equatable {
  final NavRoute route;
  final String label; // display label from AppStrings
  final int iconCodepoint; // material icon codepoint

  const NavItemModel({
    required this.route,
    required this.label,
    required this.iconCodepoint,
  });

  NavItemModel copyWith({
    NavRoute? route,
    String? label,
    int? iconCodepoint,
  }) {
    return NavItemModel(
      route: route ?? this.route,
      label: label ?? this.label,
      iconCodepoint: iconCodepoint ?? this.iconCodepoint,
    );
  }

  @override
  List<Object?> get props => [route, label, iconCodepoint];
}