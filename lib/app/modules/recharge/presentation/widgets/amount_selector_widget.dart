import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/controller/recharge_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Section to select recharge amount via quick chips or custom input
class AmountSelectorWidget extends StatelessWidget {
  final RechargeController controller;

  const AmountSelectorWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Recharge Amount',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 12.h),

          // Quick Chips
          Row(
            children: [
              Expanded(
                child: _AmountChip(
                  amount: 500,
                  isSelected: controller.selectedAmount == 500.0,
                  onTap: () => controller.selectAmount(500),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _AmountChip(
                  amount: 1000,
                  isSelected: controller.selectedAmount == 1000.0,
                  onTap: () => controller.selectAmount(1000),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _AmountChip(
                  amount: 2000,
                  isSelected: controller.selectedAmount == 2000.0,
                  onTap: () => controller.selectAmount(2000),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _AmountChip(
                  amount: 5000,
                  isSelected: controller.selectedAmount == 5000.0,
                  onTap: () => controller.selectAmount(5000),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Custom Amount Text Field
          TextField(
            controller: controller.amountController,
            keyboardType: TextInputType.number,
            onChanged: controller.onCustomAmountChanged,
            decoration: InputDecoration(
              labelText: 'Or enter custom amount (PKR)',
              labelStyle: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF64748B),
              ),
              prefixText: 'Rs. ',
              prefixStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: const Color(0xFF0F172A),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFF0E5C8A),
                  width: 1.5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Minimum: Rs. 100 · Maximum: Rs. 50,000',
            style: TextStyle(
              fontSize: 10.5.sp,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountChip extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final VoidCallback onTap;

  const _AmountChip({
    required this.amount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0E5C8A) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0E5C8A)
                : const Color(0xFFCBD5E1),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Rs. $amount',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF334155),
            ),
          ),
        ),
      ),
    );
  }
}
