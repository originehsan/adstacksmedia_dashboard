import 'package:equatable/equatable.dart';
import '../constants/app_enums.dart';

// Sidebar workspace group — expandable/collapsible section
// children list supports nested workspace items under each group
class WorkspaceModel extends Equatable {
  final String id;
  final String name; // displayed label in sidebar
  final WorkspaceType type;
  final bool isExpanded; // controls chevron rotation + child visibility
  final List<String> children; // sub-item labels shown when expanded

  const WorkspaceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.isExpanded,
    required this.children,
  });

  // Returns new instance with toggled isExpanded
  WorkspaceModel toggleExpanded() {
    return copyWith(isExpanded: !isExpanded);
  }

  WorkspaceModel copyWith({
    String? id,
    String? name,
    WorkspaceType? type,
    bool? isExpanded,
    List<String>? children,
  }) {
    return WorkspaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      isExpanded: isExpanded ?? this.isExpanded,
      children: children ?? this.children,
    );
  }

  @override
  List<Object?> get props => [id, name, type, isExpanded, children];
}