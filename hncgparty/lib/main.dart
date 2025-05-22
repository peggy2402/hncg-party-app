import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:hncgparty/features/auth/presentation/pages/login_page.dart';
import 'package:hncgparty/features/auth/presentation/pages/sigin_page.dart';
import 'package:hncgparty/features/auth/presentation/pages/home_page.dart';
import 'package:hncgparty/features/auth/presentation/pages/forgot_password.dart'; // Thêm import

import 'package:hncgparty/injection_container.dart' as di;

import 'features/auth/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HNCG Party',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Định nghĩa routes thay vì dùng home
      routes: {
        'splash': (context) => SplashScreen(),
        '/signin_up': (context) => SignInPage(),
        '/': (context) => LoginPage(),
        '/home': (context) => const HomePage(),
        '/forgot_password': (context) => const ForgotPassword(),
      },
      initialRoute: 'splash',
      // Thêm navigation observer để debug (tuỳ chọn)
      navigatorObservers: [HeroController()],
    );
  }
}