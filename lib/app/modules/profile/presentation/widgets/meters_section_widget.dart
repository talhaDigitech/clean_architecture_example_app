import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// My Meters section in the profile screen
class MetersSectionWidget extends StatelessWidget {
  final HomeController homeController;
  final VoidCallback onAddMeter;
  final void Function(BuildContext, MeterEntity) onMeterDetail;
  final void Function(BuildContext, String) onShowSnackBar;

  const MetersSectionWidget({
    super.key,
    required this.homeController,
    required this.onAddMeter,
    required this.onMeterDetail,
    required this.onShowSnackBar,
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
              'My Meters (${homeController.meters.length})',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            TextButton.icon(
              onPressed: onAddMeter,
              icon: Icon(Icons.add, size: 16.sp),
              label: const Text('Add Meter'),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeController.meters.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final meter = homeController.meters[index];
            final isDefault = index == homeController.selectedMeterIndex;
            return _MeterTile(
              meter: meter,
              isDefault: isDefault,
              onTap: () => onMeterDetail(context, meter),
              onSetDefault: () => homeController.selectMeter(index),
              onRemove: () {
                if (!homeController.removeMeter(index)) {
                  onShowSnackBar(
                    context,
                    'At least one meter must remain linked.',
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class _MeterTile extends StatelessWidget {
  final MeterEntity meter;
  final bool isDefault;
  final VoidCallback onTap;
  final VoidCallback onSetDefault;
  final VoidCallback onRemove;

  const _MeterTile({
    required this.meter,
    required this.isDefault,
    required this.onTap,
    required this.onSetDefault,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isDefault
                ? const Color(0xFF0E5C8A)
                : const Color(0xFFE2E8F0),
            width: isDefault ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0E5C8A).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.water_drop_outlined,
                size: 20.sp,
                color: const Color(0xFF0E5C8A),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          meter.meterName,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isDefault)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0E5C8A),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              fontSize: 9.5.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${meter.meterId} · Settle Day: ${meter.deviceSettleDay}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (val) {
                if (val == 'default') {
                  onSetDefault();
                } else if (val == 'remove') {
                  onRemove();
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'default',
                  child: Text('Set as Default'),
                ),
                const PopupMenuItem(
                  value: 'remove',
                  child: Text(
                    'Remove Meter',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
