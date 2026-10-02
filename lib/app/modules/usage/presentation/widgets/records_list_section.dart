import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/usage/domain/entities/usage_record_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordsListSection extends StatelessWidget {
  final List<UsageRecordEntity> records;
  final EventFilter currentFilter;
  final Function(EventFilter) onFilterChanged;
  final VoidCallback onExportTap;

  const RecordsListSection({
    super.key,
    required this.records,
    required this.currentFilter,
    required this.onFilterChanged,
    required this.onExportTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + Export Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Telemetry Records',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Historical log from WINMETER API 2.3',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0E5C8A),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              ),
              onPressed: onExportTap,
              icon: Icon(Icons.download_rounded, size: 14.sp),
              label: Text(
                'Export',
                style: TextStyle(fontSize: 11.5.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Event Filter Chips + "Alarms Only" shortcut
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'All',
                isSelected: currentFilter == EventFilter.all,
                onTap: () => onFilterChanged(EventFilter.all),
              ),
              SizedBox(width: 8.w),
              _FilterChip(
                label: '⚠️ Only Alarms',
                isSelected: currentFilter == EventFilter.alarmsOnly,
                onTap: () => onFilterChanged(EventFilter.alarmsOnly),
                highlightColor: const Color(0xFFEF4444),
              ),
              SizedBox(width: 8.w),
              _FilterChip(
                label: 'Leakage',
                isSelected: currentFilter == EventFilter.leakage,
                onTap: () => onFilterChanged(EventFilter.leakage),
              ),
              SizedBox(width: 8.w),
              _FilterChip(
                label: 'Valve Action',
                isSelected: currentFilter == EventFilter.valveAction,
                onTap: () => onFilterChanged(EventFilter.valveAction),
              ),
              SizedBox(width: 8.w),
              _FilterChip(
                label: 'Low Battery',
                isSelected: currentFilter == EventFilter.lowBattery,
                onTap: () => onFilterChanged(EventFilter.lowBattery),
              ),
              SizedBox(width: 8.w),
              _FilterChip(
                label: 'Arrears',
                isSelected: currentFilter == EventFilter.arrears,
                onTap: () => onFilterChanged(EventFilter.arrears),
              ),
              SizedBox(width: 8.w),
              _FilterChip(
                label: 'Magnetic Interference',
                isSelected: currentFilter == EventFilter.magnetic,
                onTap: () => onFilterChanged(EventFilter.magnetic),
              ),
            ],
          ),
        ),

        SizedBox(height: 14.h),

        // Records List
        if (records.isEmpty)
          Container(
            padding: EdgeInsets.symmetric(vertical: 36.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.find_in_page_outlined,
                  size: 36.sp,
                  color: const Color(0xFF94A3B8),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Is range mein koi data nahi',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Try selecting a different date range or event filter.',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: records.length,
            separatorBuilder: (context, index) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              final rec = records[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Data Gap Notice Banner
                  if (rec.hasDataGapNotice) ...[
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.cloud_off_outlined,
                            size: 15.sp,
                            color: const Color(0xFFD97706),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Meter ne is dauran data nahi bheja (Transmission gap detected)',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Record Card
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: rec.isAlarm
                            ? const Color(0xFFFCA5A5)
                            : const Color(0xFFE2E8F0),
                        width: rec.isAlarm ? 1.2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header: Clock & Report Reason Chip
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 13.sp,
                                  color: const Color(0xFF94A3B8),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  rec.deviceClock,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                              ],
                            ),
                            _ReasonBadge(
                              label: rec.reportReason,
                              isAlarm: rec.isAlarm,
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                        SizedBox(height: 10.h),

                        // Stats: Total Data, Consumption Delta, Balance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _DataColumn(
                              label: 'Total Meter Data',
                              value: '${rec.deviceTotalData.toStringAsFixed(2)} m³',
                              isHighlight: false,
                            ),
                            _DataColumn(
                              label: 'Period Consumption',
                              value: '+${rec.consumption.toStringAsFixed(2)} m³',
                              isHighlight: true,
                            ),
                            _DataColumn(
                              label: 'Account Balance',
                              value: 'Rs. ${rec.deviceBalance.toStringAsFixed(0)}',
                              isHighlight: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? highlightColor;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final activeBg = highlightColor ?? const Color(0xFF0E5C8A);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? activeBg : const Color(0xFFCBD5E1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF334155),
          ),
        ),
      ),
    );
  }
}

class _ReasonBadge extends StatelessWidget {
  final String label;
  final bool isAlarm;

  const _ReasonBadge({required this.label, required this.isAlarm});

  @override
  Widget build(BuildContext context) {
    final isLeakage = label.toLowerCase().contains('leak');
    final color = isLeakage
        ? const Color(0xFFDC2626)
        : (isAlarm ? const Color(0xFFD97706) : const Color(0xFF059669));
    final bg = isLeakage
        ? const Color(0xFFFEF2F2)
        : (isAlarm ? const Color(0xFFFFFBEB) : const Color(0xFFECFDF5));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _DataColumn extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;

  const _DataColumn({
    required this.label,
    required this.value,
    required this.isHighlight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: const Color(0xFF94A3B8),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: isHighlight
                ? const Color(0xFF0E5C8A)
                : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
