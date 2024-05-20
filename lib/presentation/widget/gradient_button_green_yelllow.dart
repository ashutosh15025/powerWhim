import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color_constant.dart';

class GradientButtonGreenYellow extends StatelessWidget {
  const GradientButtonGreenYellow({super.key, required this.buttonText});
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(colors: [
            themeColorSecond,
            themeColor,
            themeColorLight
          ]),
          ),
      child: Text(buttonText,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          textStyle:TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16
        ),)),

    );
  }
}
