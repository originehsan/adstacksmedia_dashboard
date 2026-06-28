import 'package:equatable/equatable.dart';
import '../constants/app_enums.dart';

// Represents a single project card in the dashboard
class ProjectModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String projectNumber;
  final ProjectStatus status;
  final String? thumbnailPath;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.projectNumber,
    required this.status,
    this.thumbnailPath,
  });

  String get statusLabel {
    switch (status) {
      case ProjectStatus.pending:
        return 'Pending';
      case ProjectStatus.inProgress:
        return 'In Progress';
      case ProjectStatus.done:
        return 'Done';
    }
  }

  ProjectModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? projectNumber,
    ProjectStatus? status,
    String? thumbnailPath,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      projectNumber: projectNumber ?? this.projectNumber,
      status: status ?? this.status,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        projectNumber,
        status,
        thumbnailPath,
      ];
}