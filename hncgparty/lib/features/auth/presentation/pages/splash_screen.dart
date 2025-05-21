// lib/features/auth/presentation/pages/splash_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Đợi 3 giây rồi chuyển sang LoginPage
    Timer(const Duration(milliseconds: 2400), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // hoặc bất kỳ màu nào bạn muốn
      body: Center(
        child: Lottie.asset(
          'assets/animations/loading_hncg_party_ver6.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
