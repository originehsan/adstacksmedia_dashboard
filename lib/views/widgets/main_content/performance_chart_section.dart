import 'package:adstacksmedia_dashboard/theme/app_typography.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../constants/app_strings.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../theme/app_colors.dart';
import '../../../viewmodels/dashboard_provider.dart';

// Overall Performance line chart section
// Dual lines: pending (blue) and done (green) from 2015 to 2020
class PerformanceChartSection extends ConsumerWidget {
  const PerformanceChartSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // select() prevents chart rebuild on unrelated state changes
    // e.g. sidebar toggle, calendar selection, search query
    final data = ref.watch(dashboardProvider.select((s) => s.performanceData));
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with legend
          // On mobile stack title and legend vertically
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 300;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppStrings.performanceTitle,
                          style: AppTypography.sectionTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!isNarrow) ...[
                        const Gap(8),
                       const  _ChartLegend(
                          color: AppColors.chartPending,
                          label: AppStrings.legendPending,
                        ),
                        const Gap(8),
                      const   _ChartLegend(
                          color: AppColors.chartDone,
                          label: AppStrings.legendDone,
                        ),
                      ],
                    ],
                  ),
                  if (isNarrow) ...[
                    const Gap(4),
                  const   Row(
                      children: [
                        _ChartLegend(
                          color: AppColors.chartPending,
                          label: AppStrings.legendPending,
                        ),
                         Gap(8),
                        _ChartLegend(
                          color: AppColors.chartDone,
                          label: AppStrings.legendDone,
                        ),
                      ],
                    ),
                  ],
                ],
              );
            },
          ),
          const Gap(4),
          const Text(
            AppStrings.performanceSubtitle,
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
          const Gap(16),
          // Line chart
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine:
                      (value) => const FlLine(
                        color: AppColors.chartGrid,
                        strokeWidth: 0.5,
                      ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= data.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            data[idx].year.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textMuted,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 10,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppColors.textMuted,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minY: 0,
                maxY: 60,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => AppColors.chartTooltipBg,
                    tooltipRoundedRadius: 6,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          spot.y.toInt().toString(),
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: [
                  // Pending line — blue
                  LineChartBarData(
                    spots: List.generate(
                      data.length,
                      (i) => FlSpot(i.toDouble(), data[i].pendingCount),
                    ),
                    isCurved: true,
                    color: AppColors.chartPending,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 3,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: AppColors.chartPending,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.chartPending.withAlpha(15),
                    ),
                  ),
                  // Done line — green
                  LineChartBarData(
                    spots: List.generate(
                      data.length,
                      (i) => FlSpot(i.toDouble(), data[i].doneCount),
                    ),
                    isCurved: true,
                    color: AppColors.chartDone,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        // Highlight the peak point (2019 = index 4, value 55)
                        final isPeak = data[spot.x.toInt()].doneCount == 55;
                        return FlDotCirclePainter(
                          radius: isPeak ? 5 : 3,
                          color: isPeak ? AppColors.chartDone : Colors.white,
                          strokeWidth: 2,
                          strokeColor: AppColors.chartDone,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.chartDone.withAlpha(15),
                    ),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  }
}

// Chart legend dot + label
class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const Gap(4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
