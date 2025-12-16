import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Core/Provider/app_provider.dart';
import 'home_layout.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // التأخير قبل الانتقال للصفحة الرئيسية
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Image.asset(
        "assets/images/splash_screen.png",
        width: mediaQuery.width,
        height: mediaQuery.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
