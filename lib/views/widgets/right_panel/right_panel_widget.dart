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
import '../../../utils/date_formatter.dart';
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
              const _ScheduleBanner(),
              const Gap(12),
              // Mini calendar with dropdown selectors
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
                onMonthChanged: (month) {
                  final current = ref.read(dashboardProvider).calendarFocusedDay;
                  final updated = DateTime(current.year, month, 1);
                  ref.read(dashboardProvider.notifier).changeCalendarPage(updated);
                },
                onYearChanged: (year) {
                  final current = ref.read(dashboardProvider).calendarFocusedDay;
                  final updated = DateTime(year, current.month, 1);
                  ref.read(dashboardProvider.notifier).changeCalendarPage(updated);
                },
              ),
              const Gap(16),
              // Birthday card
              if (state.todayBirthdays.isNotEmpty)
                _CelebrationCard(
                  title: AppStrings.birthdayTitle,
                  buttonLabel: AppStrings.birthdayButton,
                  colorHexList: state.todayBirthdays
                      .map((p) => p.avatarColorHex)
                      .toList(),
                  names: state.todayBirthdays.map((p) => p.name).toList(),
                  total: state.todayBirthdays.length,
                  accentColor: AppColors.warning,
                )
              else
                const _EmptyCelebrationMessage(
                  message: 'No birthdays today',
                ),
              const Gap(12),
              // Anniversary card
              if (state.anniversaries.isNotEmpty)
                _CelebrationCard(
                  title: AppStrings.anniversaryTitle,
                  buttonLabel: AppStrings.anniversaryButton,
                  colorHexList: state.anniversaries
                      .map((p) => p.avatarColorHex)
                      .toList(),
                  names: state.anniversaries.map((p) => p.name).toList(),
                  total: state.anniversaries.length,
                  accentColor: AppColors.primary,
                )
              else
                const _EmptyCelebrationMessage(
                  message: 'No anniversaries today',
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
  const _ScheduleBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primary.withAlpha(40),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.schedule_rounded,
            size: 14,
            color: AppColors.primary,
          ),
          const Gap(8),
          Expanded(
            child: Text(
              AppStrings.scheduleBanner,
              style: AppTypography.labelSm.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Mini calendar with premium OCT ∨ / 2026 ∨ dropdown selectors
class _MiniCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;
  final Function(int month) onMonthChanged;
  final Function(int year) onYearChanged;

  const _MiniCalendar({
    required this.focusedDay,
    required this.selectedDay,
    required this.firstDay,
    required this.lastDay,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Custom header with month + year dropdowns
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Month dropdown
                _CalendarDropdown(
                  value: DateFormatter.formatShortMonth(focusedDay),
                  items: DateFormatter.getShortMonthNames(),
                  onChanged: (value) {
                    final monthIndex = DateFormatter
                        .getShortMonthNames()
                        .indexOf(value) + 1;
                    if (monthIndex > 0) onMonthChanged(monthIndex);
                  },
                ),
                const Gap(8),
                // Year dropdown
                _CalendarDropdown(
                  value: DateFormatter.formatYear(focusedDay),
                  items: DateFormatter.getYearRange(
                    startYear: 2020,
                    endYear: 2030,
                  ).map((y) => y.toString()).toList(),
                  onChanged: (value) {
                    final year = int.tryParse(value);
                    if (year != null) onYearChanged(year);
                  },
                ),
              ],
            ),
          ),
          // Calendar grid — header hidden since we have custom one
          TableCalendar(
            firstDay: firstDay,
            lastDay: lastDay,
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, selectedDay),
            onDaySelected: onDaySelected,
            onPageChanged: onPageChanged,
            calendarFormat: CalendarFormat.month,
            headerVisible: false,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
              weekendStyle: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
            calendarStyle: CalendarStyle(
              cellMargin: const EdgeInsets.all(2),
              defaultTextStyle: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              weekendTextStyle: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              outsideTextStyle: AppTypography.caption.copyWith(
                color: AppColors.textMuted,
              ),
              todayDecoration: const BoxDecoration(
                color: AppColors.calendarToday,
                shape: BoxShape.circle,
              ),
              todayTextStyle: AppTypography.caption.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
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
            daysOfWeekHeight: 22,
          ),
        ],
      ),
    );
  }
}

// Premium dropdown button for month/year selection
class _CalendarDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String) onChanged;

  const _CalendarDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isDense: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 14,
            color: AppColors.textSecondary,
          ),
          style: AppTypography.labelSm.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
        ),
      ),
    );
  }
}

// Premium celebration card for birthday and anniversary
class _CelebrationCard extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final List<int> colorHexList;
  final List<String> names;
  final int total;
  final Color accentColor;

  const _CelebrationCard({
    required this.title,
    required this.buttonLabel,
    required this.colorHexList,
    required this.names,
    required this.total,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withAlpha(15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header with golden star icons
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                size: 15,
                color: accentColor,
              ),
              const Gap(4),
              Text(
                title,
                style: AppTypography.labelMd.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.star_rounded,
                size: 15,
                color: accentColor,
              ),
            ],
          ),
          const Gap(12),
          // Avatar stack + total count badge
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
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Gap(6),
              Container(
                constraints: const BoxConstraints(minWidth: 28),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(20),
                  border: Border.all(
                    color: accentColor.withAlpha(80),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  total.toString(),
                  style: AppTypography.labelMd.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Gap(12),
          // Wishing button — full width
          SizedBox(
            width: double.infinity,
            child: AppOutlinedButton(
              label: buttonLabel,
              icon: Icons.favorite_rounded,
              onPressed: () {},
              borderColor: accentColor,
              textColor: accentColor,
              iconColor: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Empty state for celebration cards
class _EmptyCelebrationMessage extends StatelessWidget {
  final String message;

  const _EmptyCelebrationMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        message,
        style: AppTypography.bodySm.copyWith(
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}