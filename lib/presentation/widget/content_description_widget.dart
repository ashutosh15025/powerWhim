import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentDescription extends StatefulWidget {
  const ContentDescription({super.key, required this.title, required this.description});
  final String title;
  final String description;

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
          Text("${widget.title}",
          style: GoogleFonts.poppins(
            textStyle:TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: Colors.yellow.shade500,
          ),),),
          Text("${widget.description}",
            style: GoogleFonts.poppins(
              textStyle:TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white,
            ),)),
        ],
      ),
    );
  }
}
