import 'package:clean_architecture_example_app/app/components/status_badge.dart';
import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MeterHealthWidget extends StatelessWidget {
  final MeterEntity meter;

  const MeterHealthWidget({super.key, required this.meter});

  String get _timeAgo {
    final diff = DateTime.now().difference(meter.updateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    return DateFormat('dd MMM, hh:mm a').format(meter.updateTime);
  }

  String get _signalQuality {
    if (meter.deviceRSSI >= -75) return 'Strong';
    if (meter.deviceRSSI >= -85) return 'Good';
    if (meter.deviceRSSI >= -95) return 'Fair';
    return 'Weak';
  }

  int get _signalBars {
    if (meter.deviceRSSI >= -75) return 4;
    if (meter.deviceRSSI >= -85) return 3;
    if (meter.deviceRSSI >= -95) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final isStale = meter.isDataStale;

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header + Feature 12: Stale Data Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.health_and_safety_outlined,
                      size: 18.sp,
                      color: const Color(0xFF0E5C8A),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        'Meter Health & Telemetry',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // Reusable Stale Data Indicator Badge (Feature 12)
              StatusBadge(
                label: isStale ? 'Stale Data' : 'Live Sync',
                type: isStale ? StatusBadgeType.warning : StatusBadgeType.success,
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // 3 Health Metrics: Voltage, Signal RSSI, Clock
          Row(
            children: [
              // 1. Voltage
              Expanded(
                child: _HealthTile(
                  icon: Icons.battery_charging_full_outlined,
                  label: 'Battery Voltage',
                  value: '${meter.deviceVoltage.toStringAsFixed(2)} V',
                  status: meter.hasLowVoltage ? 'Low Battery' : 'Optimal',
                  statusColor: meter.hasLowVoltage
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF10B981),
                ),
              ),
              Container(
                width: 1,
                height: 48.h,
                color: const Color(0xFFE2E8F0),
              ),

              // 2. Cellular / NB-IoT Signal RSSI
              Expanded(
                child: _HealthTile(
                  icon: Icons.signal_cellular_alt_outlined,
                  label: 'Signal Strength',
                  value: '${meter.deviceRSSI} dBm',
                  status: '$_signalQuality ($_signalBars/4)',
                  statusColor: _signalBars >= 3
                      ? const Color(0xFF10B981)
                      : const Color(0xFFF59E0B),
                ),
              ),
              Container(
                width: 1,
                height: 48.h,
                color: const Color(0xFFE2E8F0),
              ),

              // 3. Internal Clock
              Expanded(
                child: _HealthTile(
                  icon: Icons.access_time_outlined,
                  label: 'Meter Clock',
                  value: meter.deviceClock.split(' ').last,
                  status: 'Synced',
                  statusColor: const Color(0xFF0E5C8A),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),
          Divider(color: const Color(0xFFF1F5F9), height: 1),
          SizedBox(height: 10.h),

          // Last Sync details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last Reported to Gateway:',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              Text(
                _timeAgo,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HealthTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String status;
  final Color statusColor;

  const _HealthTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14.sp, color: const Color(0xFF64748B)),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            status,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}
