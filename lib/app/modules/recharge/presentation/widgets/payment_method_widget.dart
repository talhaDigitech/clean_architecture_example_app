import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/domain/entities/recharge_history_entity.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/controller/recharge_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Payment method selection widget
class PaymentMethodWidget extends StatelessWidget {
  final RechargeController controller;

  const PaymentMethodWidget({super.key, required this.controller});

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
            'Select Payment Gateway',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 12.h),
          _PaymentTile(
            title: 'JazzCash Mobile Account',
            subtitle: 'Instant mobile wallet payment',
            icon: Icons.phone_android_rounded,
            iconColor: const Color(0xFFDC2626),
            isSelected:
                controller.selectedMethod == PaymentMethodType.jazzCash,
            onTap: () =>
                controller.selectPaymentMethod(PaymentMethodType.jazzCash),
          ),
          SizedBox(height: 8.h),
          _PaymentTile(
            title: 'Easypaisa Wallet',
            subtitle: 'Fast checkout with OTP',
            icon: Icons.account_balance_wallet_rounded,
            iconColor: const Color(0xFF059669),
            isSelected:
                controller.selectedMethod == PaymentMethodType.easypaisa,
            onTap: () =>
                controller.selectPaymentMethod(PaymentMethodType.easypaisa),
          ),
          SizedBox(height: 8.h),
          _PaymentTile(
            title: 'Debit / Credit Card',
            subtitle: 'Visa & MasterCard 3D Secure',
            icon: Icons.credit_card_rounded,
            iconColor: const Color(0xFF0E5C8A),
            isSelected: controller.selectedMethod == PaymentMethodType.card,
            onTap: () =>
                controller.selectPaymentMethod(PaymentMethodType.card),
          ),
          SizedBox(height: 8.h),
          _PaymentTile(
            title: '1Link Bank Transfer',
            subtitle: 'Direct interbank settlement',
            icon: Icons.account_balance_rounded,
            iconColor: const Color(0xFF7C3AED),
            isSelected:
                controller.selectedMethod == PaymentMethodType.bankTransfer,
            onTap: () =>
                controller.selectPaymentMethod(PaymentMethodType.bankTransfer),
          ),
        ],
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0E5C8A).withValues(alpha: 0.04)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0E5C8A)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
              activeColor: const Color(0xFF0E5C8A),
            ),
          ],
        ),
      ),
    );
  }
}
