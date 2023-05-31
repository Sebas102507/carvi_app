import 'package:carvi/ui/screens/splash_screen.dart';
import 'package:carvi/ui/screens/start_screen.dart';
import 'package:carvi/ui/screens/take_picture_screen.dart';
import 'package:carvi/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../animations/fade_route_animation.dart';





class SplashController extends StatefulWidget {
  const SplashController({Key? key}) : super(key: key);

  @override
  _SplashControllerState createState() => _SplashControllerState();
}

class _SplashControllerState extends State<SplashController> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.push(
          context, FadeRoute(page: const StartScreen()));
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
