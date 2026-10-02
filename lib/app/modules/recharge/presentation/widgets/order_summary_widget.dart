import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/controller/recharge_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Order summary card + valve reconnect hint
class OrderSummaryWidget extends StatelessWidget {
  final MeterEntity meter;
  final RechargeController controller;

  const OrderSummaryWidget({
    super.key,
    required this.meter,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Order Summary Card
        Container(
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 10.h),
              _SummaryRow(
                label: 'Meter ID',
                value: meter.meterId,
              ),
              SizedBox(height: 6.h),
              _SummaryRow(
                label: 'Recharge Amount',
                value: 'Rs. ${controller.selectedAmount.toStringAsFixed(2)}',
              ),
              SizedBox(height: 6.h),
              _SummaryRow(
                label: 'Gateway Convenience Fee',
                value: 'Rs. 0.00 (Free)',
              ),
              const Divider(height: 18, color: Color(0xFFF1F5F9)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Payable',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    'Rs. ${controller.selectedAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0E5C8A),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // Valve Reconnect Hint
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFBBF7D0)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: Color(0xFF166534),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Arrears ke baad recharge hone par valve khulne mein meter ke agle wake-up tak time lag sakta hai.',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF166534),
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
