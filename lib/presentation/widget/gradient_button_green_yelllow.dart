import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.cyan,
              Colors.green.shade800,
              Colors.green.shade600,
              Colors.yellow.shade500,

            ],
            stops: [0.0,0.5,0.85,1.0],
          )
      ),
      child: Text(buttonText,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          textStyle:TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14
        ),)),

    );
  }
}
