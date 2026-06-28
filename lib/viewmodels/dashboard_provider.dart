import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../repository/dashboard_repository.dart';
import 'dashboard_viewmodel.dart';
import 'dashboard_state.dart';

// Provides DashboardRepository instance — swappable when real API is ready
final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepository(),
);

// Main dashboard provider — StateNotifierProvider from legacy.dart
// Calls initialize() immediately after creation to load all mock data
final dashboardProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>(
  (ref) => DashboardViewModel(
    repository: ref.read(dashboardRepositoryProvider),
  )..initialize(),
);