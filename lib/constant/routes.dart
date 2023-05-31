import 'package:carvi/ui/screens/home.dart';
import 'package:carvi/ui/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import '../ui/screens/SplashController.dart';
import '../ui/screens/logIn_screen.dart';
import '../ui/screens/sign_up_screen.dart';
import '../ui/screens/take_picture_screen.dart';


class Routes{
  static String takePictureScreen= "takePictureScreen";
  static String splashController ="splashScreenController";
  static String welcomeScreen ="welcomeScreen";
  static String loginScreen= "loginScreen";
  static String signUpScreen ="signUpScreen";
  static String home ="home";


  Map<String, WidgetBuilder> routes(){
    return {
      takePictureScreen: (context) =>  TakePictureScreen(),
      splashController: (context) => const SplashController(),
      welcomeScreen: (context) => const WelcomeScreen(),
      loginScreen: (context) => const LoginScreen(),
      signUpScreen: (context) => const SignUpScreen(),
      home: (context) => const Home(),
    };
  }



}