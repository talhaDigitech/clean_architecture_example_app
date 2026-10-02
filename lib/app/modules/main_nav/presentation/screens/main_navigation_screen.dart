import 'package:clean_architecture_example_app/app/components/custom_bottom_nav_bar.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/screens/home_screen.dart';
import 'package:clean_architecture_example_app/app/modules/main_nav/presentation/controller/main_nav_controller.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/screens/profile_screen.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/presentation/screens/recharge_screen.dart';
import 'package:clean_architecture_example_app/app/modules/usage/presentation/screens/usage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    UsageScreen(),
    RechargeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainNavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTabSelected: (index) {
          ref.read(mainNavIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
