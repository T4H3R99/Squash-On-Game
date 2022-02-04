import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:squash/Screens/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: AnimatedSplashScreen(
        backgroundColor: const Color.fromARGB(0, 123, 8, 8),
        nextScreen: const MenuScreen(),
        duration: 600,
        splash: Image.asset('assets/logo2.png'),
        splashIconSize: 250.0,
        splashTransition: SplashTransition.decoratedBoxTransition,
      )),
    );
  }
}
