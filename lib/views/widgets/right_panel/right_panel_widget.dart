import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_outlined_button.dart';
import '../../../shared/widgets/app_scrollbar.dart';
import '../../../shared/widgets/avatar_stack.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../viewmodels/dashboard_provider.dart';

// Right panel — scrollable column with schedule, calendar, birthday, anniversary
class RightPanelWidget extends ConsumerWidget {
  const RightPanelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    return Container(
      width: AppSpacing.rightPanelWidth,
      decoration: const BoxDecoration(
        color: AppColors.rightPanelBg,
        border: Border(
          left: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: AppScrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Schedule banner
              _ScheduleBanner(),
              const Gap(12),
              // Mini calendar
              _MiniCalendar(
                focusedDay: state.calendarFocusedDay,
                selectedDay: state.calendarSelectedDay,
                firstDay: state.calendarFirstDay,
                lastDay: state.calendarLastDay,
                onDaySelected: (selected, focused) => ref
                    .read(dashboardProvider.notifier)
                    .selectCalendarDay(selected, focused),
                onPageChanged: (focused) => ref
                    .read(dashboardProvider.notifier)
                    .changeCalendarPage(focused),
              ),
              const Gap(16),
              // Birthday card
              _CelebrationCard(
                title: AppStrings.birthdayTitle,
                buttonLabel: AppStrings.birthdayButton,
                colorHexList: state.todayBirthdays
                    .map((p) => p.avatarColorHex)
                    .toList(),
                names: state.todayBirthdays.map((p) => p.name).toList(),
                total: state.todayBirthdays.length,
              ),
              const Gap(12),
              // Anniversary card
              _CelebrationCard(
                title: AppStrings.anniversaryTitle,
                buttonLabel: AppStrings.anniversaryButton,
                colorHexList: state.anniversaries
                    .map((p) => p.avatarColorHex)
                    .toList(),
                names: state.anniversaries.map((p) => p.name).toList(),
                total: state.anniversaries.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Schedule timing banner
class _ScheduleBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.schedule_rounded,
            size: 14,
            color: AppColors.textSecondary,
          ),
          const Gap(6),
          Text(
            AppStrings.scheduleBanner,
            style: AppTypography.labelSm.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// Mini calendar using TableCalendar
class _MiniCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;

  const _MiniCalendar({
    required this.focusedDay,
    required this.selectedDay,
    required this.firstDay,
    required this.lastDay,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(8),
      child: TableCalendar(
        firstDay: firstDay,
        lastDay: lastDay,
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(day, selectedDay),
        onDaySelected: onDaySelected,
        onPageChanged: onPageChanged,
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: AppTypography.labelMd.copyWith(
            color: AppColors.textPrimary,
          ),
          leftChevronIcon: const Icon(
            Icons.chevron_left_rounded,
            size: 18,
            color: AppColors.textSecondary,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right_rounded,
            size: 18,
            color: AppColors.textSecondary,
          ),
          headerPadding: const EdgeInsets.symmetric(vertical: 4),
          headerMargin: EdgeInsets.zero,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: AppTypography.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
          weekendStyle: AppTypography.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(2),
          defaultTextStyle: AppTypography.caption,
          weekendTextStyle: AppTypography.caption,
          outsideTextStyle: AppTypography.caption.copyWith(
            color: AppColors.textMuted,
          ),
          todayDecoration: const BoxDecoration(
            color: AppColors.calendarToday,
            shape: BoxShape.circle,
          ),
          todayTextStyle: AppTypography.caption.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.calendarSelected,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.calendarToday,
              width: 1,
            ),
          ),
          selectedTextStyle: AppTypography.caption.copyWith(
            color: AppColors.calendarToday,
            fontWeight: FontWeight.w600,
          ),
        ),
        rowHeight: 30,
        daysOfWeekHeight: 20,
      ),
    );
  }
}

// Reusable celebration card for birthday and anniversary
class _CelebrationCard extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final List<int> colorHexList;
  final List<String> names;
  final int total;

  const _CelebrationCard({
    required this.title,
    required this.buttonLabel,
    required this.colorHexList,
    required this.names,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header with star icons
          Row(
            children: [
              const Icon(
                Icons.star_outline_rounded,
                size: 14,
                color: AppColors.warning,
              ),
              const Gap(4),
              Text(title, style: AppTypography.labelMd),
              const Spacer(),
              const Icon(
                Icons.star_outline_rounded,
                size: 14,
                color: AppColors.warning,
              ),
            ],
          ),
          const Gap(12),
          // Avatar stack + total count
          Row(
            children: [
              AvatarStack(
                colorHexList: colorHexList,
                names: names,
                size: 34,
                overlap: 10,
              ),
              const Gap(12),
              Text(
                AppStrings.totalLabel,
                style: AppTypography.bodySm,
              ),
              const Gap(4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  total.toString(),
                  style: AppTypography.labelMd,
                ),
              ),
            ],
          ),
          const Gap(12),
          // Wishing button
          AppOutlinedButton(
            label: buttonLabel,
            icon: Icons.favorite_border_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}