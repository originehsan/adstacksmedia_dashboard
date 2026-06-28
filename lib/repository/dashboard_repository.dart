import '../constants/app_enums.dart';
import '../constants/app_strings.dart';
import '../models/birthday_person_model.dart';
import '../models/creator_model.dart';
import '../models/nav_item_model.dart';
import '../models/performance_data_model.dart';
import '../models/project_model.dart';
import '../models/user_model.dart';
import '../models/workspace_model.dart';

// Single source of all mock data for the dashboard
// ViewModel calls these methods — never constructs data inline
// Swap these methods with real API calls when backend is ready
class DashboardRepository {
  // Current logged-in user shown in sidebar profile section
  UserModel getCurrentUser() {
    return const UserModel(
      id: 'u001',
      name: 'Pooja Mishra',
      role: UserRole.admin,
      avatarColorHex: 0xFF4A6CF7,
    );
  }

  // Primary nav items shown in sidebar
  List<NavItemModel> getPrimaryNavItems() {
    return const [
      NavItemModel(
        route: NavRoute.home,
        label: AppStrings.navHome,
        iconCodepoint: 0xe318, // Icons.home_rounded
      ),
      NavItemModel(
        route: NavRoute.employees,
        label: AppStrings.navEmployees,
        iconCodepoint: 0xe7fb, // Icons.people_alt_rounded
      ),
      NavItemModel(
        route: NavRoute.attendance,
        label: AppStrings.navAttendance,
        iconCodepoint: 0xe192, // Icons.access_time_rounded
      ),
      NavItemModel(
        route: NavRoute.summary,
        label: AppStrings.navSummary,
        iconCodepoint: 0xf04f4, // Icons.summarize_rounded
      ),
      NavItemModel(
        route: NavRoute.information,
        label: AppStrings.navInformation,
        iconCodepoint: 0xe4e2, // Icons.info_outline_rounded
      ),
    ];
  }

  // Bottom nav items shown on mobile only
  List<NavItemModel> getBottomNavItems() {
    return const [
      NavItemModel(
        route: NavRoute.home,
        label: AppStrings.navHome,
        iconCodepoint: 0xe318,
      ),
      NavItemModel(
        route: NavRoute.employees,
        label: AppStrings.navEmployees,
        iconCodepoint: 0xe7fb,
      ),
      NavItemModel(
        route: NavRoute.attendance,
        label: AppStrings.navAttendance,
        iconCodepoint: 0xe192,
      ),
      NavItemModel(
        route: NavRoute.settings,
        label: AppStrings.navSettings,
        iconCodepoint: 0xe8b8,
      ),
    ];
  }

  // Sidebar workspace groups with expand state
  List<WorkspaceModel> getWorkspaces() {
    return const [
      WorkspaceModel(
        id: 'ws001',
        name: AppStrings.workspaceAdstacks,
        type: WorkspaceType.main,
        isExpanded: true,
        children: ['Projects', 'Reports', 'Analytics'],
      ),
      WorkspaceModel(
        id: 'ws002',
        name: AppStrings.workspaceFinance,
        type: WorkspaceType.finance,
        isExpanded: true,
        children: ['Budget', 'Expenses', 'Invoices'],
      ),
    ];
  }

  // All Projects list in main content area
  List<ProjectModel> getProjects() {
    return const [
      ProjectModel(
        id: 'p001',
        title: 'Technology behind the Blockchain',
        subtitle: 'Blockchain infrastructure project',
        projectNumber: '1',
        status: ProjectStatus.inProgress,
      ),
      ProjectModel(
        id: 'p002',
        title: 'Technology behind the Blockchain',
        subtitle: 'Decentralized application layer',
        projectNumber: '2',
        status: ProjectStatus.pending,
      ),
      ProjectModel(
        id: 'p003',
        title: 'Technology behind the Blockchain',
        subtitle: 'Smart contract development',
        projectNumber: '3',
        status: ProjectStatus.done,
      ),
    ];
  }

  // Top Creators table in main content area
  List<CreatorModel> getTopCreators() {
    return const [
      CreatorModel(
        id: 'c001',
        name: 'Maddison',
        handle: '@maddison_c21',
        artworksCount: 9821,
        rating: 0.85,
        avatarColorHex: 0xFF4A6CF7,
      ),
      CreatorModel(
        id: 'c002',
        name: 'Karl Wilson',
        handle: '@karlwil902',
        artworksCount: 7032,
        rating: 0.65,
        avatarColorHex: 0xFF22C55E,
      ),
      CreatorModel(
        id: 'c003',
        name: 'Maddison',
        handle: '@maddison_c21',
        artworksCount: 9821,
        rating: 0.80,
        avatarColorHex: 0xFFF59E0B,
      ),
      CreatorModel(
        id: 'c004',
        name: 'Maddison',
        handle: '@maddison_c21',
        artworksCount: 9821,
        rating: 0.70,
        avatarColorHex: 0xFFEF4444,
      ),
    ];
  }

  // Overall Performance line chart data — 2015 to 2020
  List<PerformanceDataModel> getPerformanceData() {
    return const [
      PerformanceDataModel(year: 2015, pendingCount: 15, doneCount: 8),
      PerformanceDataModel(year: 2016, pendingCount: 28, doneCount: 20),
      PerformanceDataModel(year: 2017, pendingCount: 22, doneCount: 35),
      PerformanceDataModel(year: 2018, pendingCount: 38, doneCount: 25),
      PerformanceDataModel(year: 2019, pendingCount: 42, doneCount: 55),
      PerformanceDataModel(year: 2020, pendingCount: 30, doneCount: 45),
    ];
  }

  // Birthday card in right panel
  List<BirthdayPersonModel> getTodayBirthdays() {
    return [
      BirthdayPersonModel(
        id: 'b001',
        name: 'Alice Johnson',
        avatarColorHex: 0xFF4A6CF7,
        date: DateTime.now(),
        isBirthday: true,
      ),
      BirthdayPersonModel(
        id: 'b002',
        name: 'Bob Smith',
        avatarColorHex: 0xFF22C55E,
        date: DateTime.now(),
        isBirthday: true,
      ),
    ];
  }

  // Anniversary card in right panel
  List<BirthdayPersonModel> getAnniversaries() {
    return [
      BirthdayPersonModel(
        id: 'a001',
        name: 'Carol White',
        avatarColorHex: 0xFFF59E0B,
        date: DateTime.now(),
        isBirthday: false,
      ),
      BirthdayPersonModel(
        id: 'a002',
        name: 'Dave Brown',
        avatarColorHex: 0xFFEF4444,
        date: DateTime.now(),
        isBirthday: false,
      ),
      BirthdayPersonModel(
        id: 'a003',
        name: 'Eve Davis',
        avatarColorHex: 0xFF8B5CF6,
        date: DateTime.now(),
        isBirthday: false,
      ),
    ];
  }

  // Initial calendar state for right panel mini calendar
  DateTime getInitialFocusedDay() => DateTime.now();
  DateTime getInitialSelectedDay() => DateTime.now();
}