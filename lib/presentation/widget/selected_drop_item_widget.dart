import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedDropItemWidget extends StatelessWidget {
  const SelectedDropItemWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "${title} ashes",
        style: GoogleFonts.baloo2(
          textStyle: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 12
          )
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.green,

      ),

    );
  }
}
