import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:hncgparty/features/auth/presentation/pages/login_page.dart';
import 'package:hncgparty/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Khởi tạo dependency injection
  runApp(const MyApp());
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
      home: BlocProvider<AuthBloc>(
        create: (_) => di.sl<AuthBloc>(), // Lấy AuthBloc từ service locator
        child: LoginPage(), // Trang đăng nhập
      ),
    );
  }
}
