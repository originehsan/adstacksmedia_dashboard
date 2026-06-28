import 'package:flutter_riverpod/legacy.dart';
import '../constants/app_enums.dart';
import '../repository/dashboard_repository.dart';
import '../utils/app_logger.dart';
import 'dashboard_state.dart';

// All dashboard business logic lives here
// No BuildContext, no Widget, no UI imports allowed
class DashboardViewModel extends StateNotifier<DashboardState> {
  final DashboardRepository _repository;

  DashboardViewModel({required DashboardRepository repository})
      : _repository = repository,
        super(
          DashboardState(
            calendarFocusedDay: DateTime.now(),
            calendarSelectedDay: DateTime.now(),
            calendarFirstDay: DateTime.utc(2020, 1, 1),
            calendarLastDay: DateTime.utc(2030, 12, 31),
          ),
        );

  // Called once when provider is created — loads all mock data into state
  void initialize() {
    AppLogger.info('DashboardViewModel: initializing');
    try {
      state = state.copyWith(
        currentUser: _repository.getCurrentUser(),
        primaryNavItems: _repository.getPrimaryNavItems(),
        bottomNavItems: _repository.getBottomNavItems(),
        workspaces: _repository.getWorkspaces(),
        projects: _repository.getProjects(),
        topCreators: _repository.getTopCreators(),
        performanceData: _repository.getPerformanceData(),
        todayBirthdays: _repository.getTodayBirthdays(),
        anniversaries: _repository.getAnniversaries(),
        calendarFocusedDay: _repository.getInitialFocusedDay(),
        calendarSelectedDay: _repository.getInitialSelectedDay(),
        isLoading: false,
      );
      AppLogger.info('DashboardViewModel: initialized successfully');
    } catch (e, st) {
      AppLogger.error(
        'DashboardViewModel: initialization failed',
        error: e,
        stackTrace: st,
      );
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load dashboard data.',
      );
    }
  }

  // Updates active nav route — drives main content area swap
  void selectNav(NavRoute route) {
    AppLogger.debug('DashboardViewModel: selectNav -> $route');
    state = state.copyWith(activeRoute: route);
  }

  // Toggles sidebar between full (240px) and collapsed (64px)
  void toggleSidebar() {
    state = state.copyWith(
      isSidebarCollapsed: !state.isSidebarCollapsed,
    );
  }

  void expandSidebar() {
    state = state.copyWith(isSidebarCollapsed: false);
  }

  void collapseSidebar() {
    state = state.copyWith(isSidebarCollapsed: true);
  }

  // Toggles a single workspace expand/collapse by id
  void toggleWorkspace(String workspaceId) {
    final updated = state.workspaces.map((ws) {
      if (ws.id == workspaceId) return ws.toggleExpanded();
      return ws;
    }).toList();
    state = state.copyWith(workspaces: updated);
  }

  // Called from TableCalendar onDaySelected
  // Both selectedDay and focusedDay must update together
  void selectCalendarDay(DateTime selectedDay, DateTime focusedDay) {
    state = state.copyWith(
      calendarSelectedDay: selectedDay,
      calendarFocusedDay: focusedDay,
    );
  }

  // Called from TableCalendar onPageChanged
  // Only focusedDay updates — prevents calendar reset on rebuild
  void changeCalendarPage(DateTime focusedDay) {
    state = state.copyWith(calendarFocusedDay: focusedDay);
  }

  // Toggles right panel overlay on desktop-sm (900–1200px)
  void toggleRightPanel() {
    state = state.copyWith(
      isRightPanelVisible: !state.isRightPanelVisible,
    );
  }

  // Updates search query from top navbar search bar
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  // Clears any error message shown to user
  void dismissError() {
    state = state.copyWith(errorMessage: null);
  }
}