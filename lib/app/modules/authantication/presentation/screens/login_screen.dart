import 'package:clean_architecture_example_app/app/components/primary_button.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/routes/api_routes.dart';
import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_assets.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_strings.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/presentation/controller/auth_provider.dart';
import 'package:clean_architecture_example_app/app/modules/main_nav/presentation/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 36.h),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Winmeter Logo with Hero animation
              Hero(
                tag: 'logo',
                child: Container(
                  width: 220.w,
                  height: 90.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0E5C8A).withValues(alpha: 0.08),
                        blurRadius: 28,
                        spreadRadius: 2,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    AppAssets.winmeterLogo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              Text(
                'Welcome to Winmeter',
                style: AppTypography.headlineSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Enterprise Meter Management Platform\nTap below to connect securely to your account',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: const Color(0xFF64748B),
                    height: 1.5,
                  ),
                ),
              ),

              const Spacer(flex: 3),

              // Single Connect / Sign In button
              PrimaryButton(
                buttonText: AppString.signIn,
                isLoading: auth.hasLoader(ApiRoutes.login),
                onPressed: () {
                  ref.read(authProvider).login(
                    onSuccess: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MainNavigationScreen(),
                        ),
                      );
                    },
                  );
                },
                buttonWidth: double.infinity,
                buttonHeight: 52.h,
                borderRadius: BorderRadius.circular(14.r),
              ),

              SizedBox(height: 20.h),

              // Security & Version footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    size: 15.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'OAuth 2.0 Secure · Winmeter v1.0.0',
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
