import 'package:flutter/material.dart';
import 'package:hncg_app/core/theme/app_theme.dart'; 
import 'package:hncg_app/core/injection_container.dart';
import 'package:hncg_app/features/auth/presentation/pages/login_page.dart'; 
import 'package:hncg_app/core/routes/app_router.dart';
import 'package:get_it/get_it.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HNCG',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Sử dụng light theme
      darkTheme: AppTheme.darkTheme, // Dark theme (tuỳ chọn)
      themeMode: ThemeMode.system, // Tự động theo hệ thống
      home: const LoginPage(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      navigatorKey: GetIt.I<GlobalKey<NavigatorState>>(),
    );
  }
}