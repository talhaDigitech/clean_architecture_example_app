import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/controller/home_controller.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/meter_selector_bottom_sheet.dart';
import 'package:clean_architecture_example_app/app/modules/usage/domain/entities/usage_record_entity.dart';
import 'package:clean_architecture_example_app/app/modules/usage/presentation/controller/usage_controller.dart';
import 'package:clean_architecture_example_app/app/modules/usage/presentation/widgets/records_list_section.dart';
import 'package:clean_architecture_example_app/app/modules/usage/presentation/widgets/usage_bar_chart_widget.dart';
import 'package:clean_architecture_example_app/app/modules/usage/presentation/widgets/usage_summary_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class UsageScreen extends ConsumerWidget {
  const UsageScreen({super.key});

  void _showExportDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Export Consumption Report',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Download telemetry and audit logs for your records.',
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
            ),
            SizedBox(height: 20.h),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(Icons.table_chart_outlined, color: Color(0xFF059669)),
              ),
              title: const Text('Export as CSV Spreadsheet'),
              subtitle: const Text('Compatible with Microsoft Excel & Google Sheets'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Downloading CSV Consumption Report...'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(Icons.picture_as_pdf_outlined, color: Color(0xFFDC2626)),
              ),
              title: const Text('Export as PDF Statement'),
              subtitle: const Text('Official utility consumption statement format'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Generating PDF Consumption Statement...'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickCustomRange(
      BuildContext context, UsageController controller) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: controller.customDateRange ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 14)),
            end: DateTime.now(),
          ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0E5C8A),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.setCustomRange(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeController = ref.watch(homeControllerProvider);
    final usageController = ref.watch(usageControllerProvider);

    if (homeController.isLoading ||
        homeController.state == HomeViewState.loading ||
        homeController.currentMeter == null ||
        usageController.isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0E5C8A)),
            ),
          ),
        ),
      );
    }

    final currentMeter = homeController.currentMeter!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Water Consumption',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Detailed historical telemetry & audits',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              // Selected Meter Selector Card
              GestureDetector(
                onTap: () {
                  MeterSelectorBottomSheet.show(
                    context,
                    meters: homeController.meters,
                    selectedIndex: homeController.selectedMeterIndex,
                    onSelect: homeController.selectMeter,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0E5C8A).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.water_drop_outlined,
                          size: 18.sp,
                          color: const Color(0xFF0E5C8A),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentMeter.meterName,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'ID: ${currentMeter.meterId} · ${currentMeter.deviceAddress}',
                              style: TextStyle(
                                fontSize: 10.5.sp,
                                color: const Color(0xFF64748B),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.unfold_more,
                        size: 18.sp,
                        color: const Color(0xFF0E5C8A),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Date Range Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _RangeChip(
                      label: 'Today',
                      isSelected: usageController.range == UsageRange.today,
                      onTap: () => usageController.setRange(UsageRange.today),
                    ),
                    SizedBox(width: 8.w),
                    _RangeChip(
                      label: '7D',
                      isSelected: usageController.range == UsageRange.days7,
                      onTap: () => usageController.setRange(UsageRange.days7),
                    ),
                    SizedBox(width: 8.w),
                    _RangeChip(
                      label: '30D',
                      isSelected: usageController.range == UsageRange.days30,
                      onTap: () => usageController.setRange(UsageRange.days30),
                    ),
                    SizedBox(width: 8.w),
                    _RangeChip(
                      label: 'This Month',
                      isSelected:
                          usageController.range == UsageRange.thisMonth,
                      onTap: () =>
                          usageController.setRange(UsageRange.thisMonth),
                    ),
                    SizedBox(width: 8.w),
                    _RangeChip(
                      label: 'Last Month',
                      isSelected:
                          usageController.range == UsageRange.lastMonth,
                      onTap: () =>
                          usageController.setRange(UsageRange.lastMonth),
                    ),
                    SizedBox(width: 8.w),
                    _RangeChip(
                      label: usageController.customDateRange != null
                          ? '${DateFormat('MM/dd').format(usageController.customDateRange!.start)} - ${DateFormat('MM/dd').format(usageController.customDateRange!.end)}'
                          : 'Custom 📅',
                      isSelected: usageController.range == UsageRange.custom,
                      onTap: () => _pickCustomRange(context, usageController),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 18.h),

              // Summary Metrics Grid
              UsageSummaryGrid(
                totalUsage: usageController.totalUsage,
                dailyAverage: usageController.dailyAverage,
                peakDayLabel: usageController.peakDay.label,
                peakDayValue: usageController.peakDay.value,
                comparisonText: usageController.comparisonString,
              ),

              SizedBox(height: 18.h),

              // Main Bar Chart (fl_chart)
              UsageBarChartWidget(
                dataPoints: usageController.chartData,
                timeMode: usageController.timeMode,
                onModeChanged: usageController.setTimeMode,
              ),

              SizedBox(height: 16.h),

              // 3-Hourly Consumption Push Data Card
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.timelapse_outlined,
                                size: 16.sp,
                                color: const Color(0xFF38BDF8),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '3-Hourly Cycle Telemetry',
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF38BDF8).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'Cycle Push Data',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF38BDF8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Push data ke cycleDataObject.reportContent se 3-hourly breakdown generate hota hai. Yeh tabhi available hota hai jab backend push packets persist kare.',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: const Color(0xFF94A3B8),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Telemetry Records List Section
              RecordsListSection(
                records: usageController.records,
                currentFilter: usageController.filter,
                onFilterChanged: usageController.setFilter,
                onExportTap: () => _showExportDialog(context),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _RangeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RangeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0E5C8A) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF0E5C8A) : const Color(0xFFCBD5E1),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0E5C8A).withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.5.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF334155),
          ),
        ),
      ),
    );
  }
}
