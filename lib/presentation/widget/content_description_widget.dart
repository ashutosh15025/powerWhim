import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentDescription extends StatefulWidget {
  const ContentDescription({super.key});

  @override
  State<ContentDescription> createState() => _ContentDescriptionState();
}

class _ContentDescriptionState extends State<ContentDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hobbies:",
          style: GoogleFonts.roboto(
            textStyle:TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: Colors.yellow.shade600,
          ),),),
          Text("This is my hobbies which i love to do this is my hobbies which i love to do this is my hobbies which i love to do this is my hobbies which i love to do",
            style: GoogleFonts.roboto(
              textStyle:TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.white,
            ),)),
        ],
      ),
    );
  }
}
