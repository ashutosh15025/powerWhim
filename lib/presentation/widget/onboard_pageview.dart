import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class onBoardPageView extends StatelessWidget {
  const onBoardPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
          height: MediaQuery.of(context).size.height/2,
          child: Center(
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0),
              height: 250,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/icon/logo.png'), // Replace with your asset path
                radius: 125,
                backgroundColor: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
          child: Text("Find people who match with you",
                  style: GoogleFonts.baloo2(
                 textStyle: TextStyle(
                     fontSize: 24,
                     color: Colors.white,
                     fontWeight: FontWeight.w600
                 )
                       ),
                textAlign: TextAlign.center,
              ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
          child: Text("Join us socialize with millions of power which change match",
            style: GoogleFonts.baloo2(
                textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                )
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
