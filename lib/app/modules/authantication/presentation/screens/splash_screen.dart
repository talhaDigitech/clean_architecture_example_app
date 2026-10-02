import 'package:clean_architecture_example_app/app/core/handlers/auth_handler.dart';
import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_assets.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/presentation/screens/login_screen.dart';
import 'package:clean_architecture_example_app/app/modules/main_nav/presentation/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _scaleAnim = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _animController.forward();
    _checkAuth();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 2200));

    // Initialize persisted auth state
    await AuthHandler.ref.init();

    if (!mounted) return;

    final isLoggedIn = AuthHandler.ref.isLoggedIn;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) =>
            isLoggedIn ? const MainNavigationScreen() : const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFF1F5F9),
              Color(0xFFE2E8F0),
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),

              // Animated Logo & Title block
              FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo Card with glowing elevation
                        Hero(
                          tag: 'logo',
                          child: Container(
                            width: 240.w,
                            height: 100.h,
                            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0E5C8A).withValues(alpha: 0.12),
                                  blurRadius: 36,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 14),
                                ),
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              AppAssets.winmeterLogo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        SizedBox(height: 28.h),

                        // App Name
                        Text(
                          'WINMETER',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3.5,
                            color: const Color(0xFF0F172A),
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // Subtitle
                        Text(
                          'Enterprise Meter Management Platform',
                          style: AppTypography.bodySmall.copyWith(
                            fontSize: 13.sp,
                            letterSpacing: 0.6,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 3),

              // Bottom Loader & Version Tag
              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  children: [
                    SizedBox(
                      width: 36.w,
                      height: 36.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF0E5C8A),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Connecting secure services...',
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xFF94A3B8),
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 18.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
