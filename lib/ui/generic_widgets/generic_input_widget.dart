import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/colors.dart';


class GenericInput extends StatelessWidget {

  TextEditingController? controller;
  Color backgroudColor;
  Color shadowColor;
  String title;
  bool enable;
  bool autofocus;


  GenericInput({Key? key, required this.controller,
    required this.backgroudColor,required this.shadowColor,
    required this.title,
    required this.enable,
    this.autofocus=false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroudColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
       boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(
          padding: const EdgeInsets.all(5),
          child: TextFormField(
            autofocus: autofocus,
            enabled: enable,
            controller: controller,
            style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.grey[400],
                fontWeight: FontWeight.bold
            ),
            cursorColor: mainBlue,
            decoration: InputDecoration(
              hintText: title,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: mainBlue),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: mainBlue),
              ),
            ),
          )
      ),
    );

  }

}
