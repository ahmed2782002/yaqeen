import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Core/Provider/app_provider.dart';
import 'home_layout.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "splash-screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    });
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Image.asset(
        appProvider.splashScreen(),
        width: mediaQuery.width,
        height: mediaQuery.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
