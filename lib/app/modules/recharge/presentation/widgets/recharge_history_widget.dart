import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/domain/entities/recharge_history_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// History list section with receipt viewer
class RechargeHistoryWidget extends StatelessWidget {
  final List<RechargeHistoryEntity> history;
  final void Function(BuildContext, RechargeHistoryEntity) onReceiptTap;

  const RechargeHistoryWidget({
    super.key,
    required this.history,
    required this.onReceiptTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recharge History',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            Text(
              'Backend Records',
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final txn = history[index];
            return _HistoryTile(
              txn: txn,
              onTap: () => onReceiptTap(context, txn),
            );
          },
        ),
      ],
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final RechargeHistoryEntity txn;
  final VoidCallback onTap;

  const _HistoryTile({required this.txn, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0E5C8A).withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_long_outlined,
                  size: 18.sp,
                  color: const Color(0xFF0E5C8A),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rs. ${txn.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${txn.methodName} · ${DateFormat('MMM dd, yyyy').format(txn.date)}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: txn.status == RechargeStatus.success
                      ? const Color(0xFFECFDF5)
                      : const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  txn.statusLabel,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: txn.status == RechargeStatus.success
                        ? const Color(0xFF059669)
                        : const Color(0xFFD97706),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  Icons.chevron_right,
                  size: 18.sp,
                  color: const Color(0xFF94A3B8),
                ),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
