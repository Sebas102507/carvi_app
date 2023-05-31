import 'package:carvi/themes/colors.dart';
import 'package:flutter/material.dart';

import '../../constant/assetImages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: lightRed,
          child: Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetImages.logoSimple)
                  )
              ),
            ),
          ),
        )
    );
  }
}





