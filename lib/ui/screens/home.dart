import 'package:carvi/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../constant/assetImages.dart';
import '../../constant/routes.dart';
import '../../constant/strings.dart';
import '../../services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {


  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller=VideoPlayerController.asset(AssetImages.backgroundVideo)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }



  @override
  Widget build(BuildContext context) {
    final authService= Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            Strings.homeTitle,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainBlue,fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        )
                    ),
                      Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: (){
                                authService.signOut();
                              },
                              child: const Icon(
                                Icons.exit_to_app,
                                color: lightRed,
                                size: 30,
                              ),
                            )
                          )
                      ),
                    ],
                  )
              ),
              Expanded(
                  flex: 10,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context,Routes.takePictureScreen);
                    },
                    child: Container(
                        margin: const EdgeInsets.all(70),
                        decoration:  const BoxDecoration(
                            color: lightRed,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Stack(
                          children: const [
                            Center(
                                child:  Icon(
                                  Icons.camera_alt,
                                  color: lightGrey,
                                  size: 40,
                                ),
                            ),
                          ],
                        )
                    ),
                  )
              )
            ],
          ),
        )
      )
    );
  }
}
