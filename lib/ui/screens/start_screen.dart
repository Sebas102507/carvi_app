import 'package:carvi/ui/screens/take_picture_screen.dart';
import 'package:carvi/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/auth_service.dart';
import 'home.dart';



class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    final authService= Provider.of<AuthService>(context);

    return StreamBuilder(
      stream: authService.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData || snapshot.hasError){
          return const WelcomeScreen();
        }
        else{
          return const Home();
        }
      },
    );
  }
}

