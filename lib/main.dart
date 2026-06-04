import 'package:clean_architecture_example_app/app/core/services/registry_service/di.dart';
import 'package:clean_architecture_example_app/app/core/theme/app_theme.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_snack_bar.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load environment variables
  await dotenv.load(fileName: ".env");

  // Single Registry Setup
  setupLocator();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Clean Architecture Example App',
          navigatorKey: Prompt.navigatorKey,
          scaffoldMessengerKey: Prompt.messengerKey,
          darkTheme: AppTheme.lightTheme,

          theme: AppTheme.lightTheme,
          home: LoginScreen(),
        );
      },
    );
  }
}
