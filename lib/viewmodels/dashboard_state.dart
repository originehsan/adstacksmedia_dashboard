import 'package:equatable/equatable.dart';
import '../constants/app_enums.dart';
import '../models/birthday_person_model.dart';
import '../models/creator_model.dart';
import '../models/nav_item_model.dart';
import '../models/performance_data_model.dart';
import '../models/project_model.dart';
import '../models/user_model.dart';
import '../models/workspace_model.dart';

// Immutable state object for the entire dashboard screen
// All UI state lives here — no local state in screens or widgets
class DashboardState extends Equatable {
  final UserModel? currentUser;
  final List<NavItemModel> primaryNavItems;
  final List<NavItemModel> bottomNavItems;
  final List<WorkspaceModel> workspaces;
  final List<ProjectModel> projects;
  final List<CreatorModel> topCreators;
  final List<PerformanceDataModel> performanceData;
  final List<BirthdayPersonModel> todayBirthdays;
  final List<BirthdayPersonModel> anniversaries;

  // Navigation
  final NavRoute activeRoute;

  // Sidebar
  final bool isSidebarCollapsed;

  // Right panel — overlay toggle for desktop-sm (900–1200px)
  final bool isRightPanelVisible;

  // Calendar state — persisted to prevent TableCalendar reset on rebuild
  final DateTime calendarFocusedDay;
  final DateTime calendarSelectedDay;
  final DateTime calendarFirstDay;
  final DateTime calendarLastDay;

  // Search
  final String searchQuery;

  // Loading and error
  final bool isLoading;
  final String? errorMessage;

  const DashboardState({
    this.currentUser,
    this.primaryNavItems = const [],
    this.bottomNavItems = const [],
    this.workspaces = const [],
    this.projects = const [],
    this.topCreators = const [],
    this.performanceData = const [],
    this.todayBirthdays = const [],
    this.anniversaries = const [],
    this.activeRoute = NavRoute.home,
    this.isSidebarCollapsed = false,
    this.isRightPanelVisible = false,
    required this.calendarFocusedDay,
    required this.calendarSelectedDay,
    required this.calendarFirstDay,
    required this.calendarLastDay,
    this.searchQuery = '',
   this.isLoading = true,
    this.errorMessage,
  });

  DashboardState copyWith({
    UserModel? currentUser,
    List<NavItemModel>? primaryNavItems,
    List<NavItemModel>? bottomNavItems,
    List<WorkspaceModel>? workspaces,
    List<ProjectModel>? projects,
    List<CreatorModel>? topCreators,
    List<PerformanceDataModel>? performanceData,
    List<BirthdayPersonModel>? todayBirthdays,
    List<BirthdayPersonModel>? anniversaries,
    NavRoute? activeRoute,
    bool? isSidebarCollapsed,
    bool? isRightPanelVisible,
    DateTime? calendarFocusedDay,
    DateTime? calendarSelectedDay,
    DateTime? calendarFirstDay,
    DateTime? calendarLastDay,
    String? searchQuery,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      currentUser: currentUser ?? this.currentUser,
      primaryNavItems: primaryNavItems ?? this.primaryNavItems,
      bottomNavItems: bottomNavItems ?? this.bottomNavItems,
      workspaces: workspaces ?? this.workspaces,
      projects: projects ?? this.projects,
      topCreators: topCreators ?? this.topCreators,
      performanceData: performanceData ?? this.performanceData,
      todayBirthdays: todayBirthdays ?? this.todayBirthdays,
      anniversaries: anniversaries ?? this.anniversaries,
      activeRoute: activeRoute ?? this.activeRoute,
      isSidebarCollapsed: isSidebarCollapsed ?? this.isSidebarCollapsed,
      isRightPanelVisible: isRightPanelVisible ?? this.isRightPanelVisible,
      calendarFocusedDay: calendarFocusedDay ?? this.calendarFocusedDay,
      calendarSelectedDay: calendarSelectedDay ?? this.calendarSelectedDay,
      calendarFirstDay: calendarFirstDay ?? this.calendarFirstDay,
      calendarLastDay: calendarLastDay ?? this.calendarLastDay,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        primaryNavItems,
        bottomNavItems,
        workspaces,
        projects,
        topCreators,
        performanceData,
        todayBirthdays,
        anniversaries,
        activeRoute,
        isSidebarCollapsed,
        isRightPanelVisible,
        calendarFocusedDay,
        calendarSelectedDay,
        calendarFirstDay,
        calendarLastDay,
        searchQuery,
        isLoading,
        errorMessage,
      ];
}