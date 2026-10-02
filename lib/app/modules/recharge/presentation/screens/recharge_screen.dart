import 'package:clean_architecture_example_app/app/components/primary_button.dart';
import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/controller/home_controller.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/domain/entities/recharge_history_entity.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/controller/recharge_controller.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/widgets/amount_selector_widget.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/widgets/arrears_banner_widget.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/widgets/balance_hero_card.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/widgets/order_summary_widget.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/widgets/payment_method_widget.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/widgets/recharge_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RechargeScreen extends ConsumerWidget {
  const RechargeScreen({super.key});

  void _showReceiptDialog(BuildContext context, RechargeHistoryEntity item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 28.h),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction Receipt',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: item.status == RechargeStatus.success
                        ? const Color(0xFFECFDF5)
                        : const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    item.statusLabel,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: item.status == RechargeStatus.success
                          ? const Color(0xFF059669)
                          : const Color(0xFFD97706),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _ReceiptRow(label: 'Transaction ID', value: item.transactionId),
                  const Divider(height: 16, color: Color(0xFFE2E8F0)),
                  _ReceiptRow(label: 'Meter ID', value: item.meterId),
                  const Divider(height: 16, color: Color(0xFFE2E8F0)),
                  _ReceiptRow(label: 'Payment Method', value: item.methodName),
                  const Divider(height: 16, color: Color(0xFFE2E8F0)),
                  _ReceiptRow(
                    label: 'Date & Time',
                    value: DateFormat('yyyy-MM-dd HH:mm').format(item.date),
                  ),
                  const Divider(height: 16, color: Color(0xFFE2E8F0)),
                  _ReceiptRow(
                    label: 'Amount Paid',
                    value: 'Rs. ${item.amount.toStringAsFixed(2)}',
                    isBold: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Receipt link copied!')),
                      );
                    },
                    icon: const Icon(Icons.share_outlined, size: 16),
                    label: const Text('Share'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E5C8A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Downloading PDF Receipt...')),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, size: 16),
                    label: const Text('Download'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeController = ref.watch(homeControllerProvider);
    final rechargeController = ref.watch(rechargeControllerProvider);

    if (homeController.isLoading ||
        homeController.state == HomeViewState.loading ||
        homeController.currentMeter == null ||
        rechargeController.isLoadingHistory) {
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

    final meter = homeController.currentMeter!;

    final isArrears = meter.feeStatus == 2;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen Header
              Text(
                'Recharge & Wallet',
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
                'Prepaid credit for water meter',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF64748B),
                ),
              ),

              SizedBox(height: 14.h),

              // Feature: Current Balance Hero Card
              BalanceHeroCard(meter: meter),

              SizedBox(height: 14.h),

              // Feature: Arrears Warning Banner
              if (isArrears) ...[
                const ArrearsBannerWidget(),
                SizedBox(height: 14.h),
              ],

              // Feature: Post-payment Pending Sync Banner
              if (rechargeController.hasPendingSync) ...[
                PendingSyncBannerWidget(controller: rechargeController),
                SizedBox(height: 14.h),
              ],

              // Feature: Amount Selection
              AmountSelectorWidget(controller: rechargeController),

              SizedBox(height: 16.h),

              // Feature: Payment Method Selector
              PaymentMethodWidget(controller: rechargeController),

              SizedBox(height: 16.h),

              // Feature: Order Summary + Valve Reconnect Hint
              OrderSummaryWidget(meter: meter, controller: rechargeController),

              SizedBox(height: 18.h),

              // Proceed to Pay Button
              PrimaryButton(
                buttonText:
                    'Pay Rs. ${rechargeController.selectedAmount.toStringAsFixed(0)}',
                isLoading: rechargeController.isProcessing,
                onPressed: () async {
                  await rechargeController.processPayment(
                    meterId: meter.meterId,
                    onMeterTopUp: () {
                      homeController
                          .topUpBalance(rechargeController.selectedAmount);
                    },
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color(0xFF10B981),
                        content: Text(
                          'Payment processed! Waiting for meter gateway sync.',
                        ),
                      ),
                    );
                  }
                },
                buttonWidth: double.infinity,
                buttonHeight: 50.h,
                borderRadius: BorderRadius.circular(14.r),
              ),

              SizedBox(height: 26.h),

              // Feature: Recharge History
              RechargeHistoryWidget(
                history: rechargeController.history,
                onReceiptTap: _showReceiptDialog,
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _ReceiptRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

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
            fontSize: 12.5.sp,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: isBold ? const Color(0xFF0E5C8A) : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
