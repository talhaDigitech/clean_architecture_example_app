import 'package:clean_architecture_example_app/app/components/confirm_dialog.dart';
import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ValveControlWidget extends StatelessWidget {
  final MeterEntity meter;
  final bool isOperating;
  final Future<void> Function() onToggleRequested;

  const ValveControlWidget({
    super.key,
    required this.meter,
    required this.isOperating,
    required this.onToggleRequested,
  });

  void _showConfirmationDialog(BuildContext context) {
    final willOpen = !meter.isValveOpen;
    ConfirmDialog.show(
      context,
      title: willOpen ? 'Open Valve?' : 'Close Valve?',
      message: willOpen
          ? 'Are you sure you want to open the valve to resume supply?'
          : 'Are you sure you want to close the valve and shut off supply?',
      confirmText: willOpen ? 'Open' : 'Close',
      confirmColor: willOpen ? const Color(0xFF10B981) : const Color(0xFFEF4444),
      icon: willOpen ? Icons.water_drop_outlined : Icons.power_settings_new,
      onConfirm: onToggleRequested,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOpen = meter.isValveOpen;
    final statusColor =
        isOpen ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final statusBg =
        isOpen ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2);

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Valve Icon & Status — Expanded so it never pushes button out
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: statusBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isOpen
                            ? Icons.water_drop_outlined
                            : Icons.block_outlined,
                        color: statusColor,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Valve Control',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Container(
                                width: 7.w,
                                height: 7.w,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Flexible(
                                child: Text(
                                  isOpen ? 'SUPPLY ACTIVE' : 'SUPPLY HALTED',
                                  style: TextStyle(
                                    fontSize: 10.5.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    color: statusColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),

              // Action Button / Spinner
              if (isOperating)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 14.w,
                        height: 14.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF0E5C8A),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Updating...',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                )
              else
                GestureDetector(
                  onTap: () => _showConfirmationDialog(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: isOpen
                          ? const Color(0xFFFEF2F2)
                          : const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: isOpen
                            ? const Color(0xFFFCA5A5)
                            : const Color(0xFFA7F3D0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isOpen ? Icons.power_settings_new : Icons.play_arrow,
                          size: 14.sp,
                          color: isOpen
                              ? const Color(0xFFDC2626)
                              : const Color(0xFF059669),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          isOpen ? 'Close Valve' : 'Open Valve',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: isOpen
                                ? const Color(0xFFDC2626)
                                : const Color(0xFF059669),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
