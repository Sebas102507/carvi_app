import 'package:flutter/material.dart';

import '../../themes/colors.dart';

class LoadingWidget extends StatefulWidget {
  LoadingWidget();
  @override
  _LoadingWidget createState() => _LoadingWidget();
}

class _LoadingWidget extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.8),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(lightRed),
        ),
      ),
    );

  }
}
