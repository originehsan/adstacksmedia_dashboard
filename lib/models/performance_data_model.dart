import 'package:equatable/equatable.dart';

// Single data point for the Overall Performance line chart
// x-axis = year, y-axis = pendingCount and doneCount as dual lines
class PerformanceDataModel extends Equatable {
  final int year; // x-axis label on chart
  final double pendingCount; // blue line — pending projects
  final double doneCount; // green line — completed projects

  const PerformanceDataModel({
    required this.year,
    required this.pendingCount,
    required this.doneCount,
  });

  PerformanceDataModel copyWith({
    int? year,
    double? pendingCount,
    double? doneCount,
  }) {
    return PerformanceDataModel(
      year: year ?? this.year,
      pendingCount: pendingCount ?? this.pendingCount,
      doneCount: doneCount ?? this.doneCount,
    );
  }

  @override
  List<Object?> get props => [year, pendingCount, doneCount];
}