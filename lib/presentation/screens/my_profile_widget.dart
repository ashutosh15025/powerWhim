import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/service_api_constant.dart';
import '../widget/content_description_widget.dart';
import '../widget/profile_images_widget.dart';

class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({super.key});

  @override
  State<MyProfileWidget> createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      color: Color.fromRGBO(0, 0, 0, 0.95),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children:[Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("Jennefer Lucy",
                  style: GoogleFonts.poppins(
                    textStyle:TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: green),)
              ),
            ),
              Spacer()
              ,Text("30 yrs",
                style: GoogleFonts.poppins(
                  textStyle:TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: green),),)]),
            ContentDescription(title: "Sports:",description: "Football, Hockey"),
            ContentDescription(title: "Hobbies:",description: "Knitting and travel"),
            ContentDescription(title: "Ambition:",description: "Run a marathon \nRun a 100km marathon \nRun a 100km marathon \nRun a 100km marathon  "),
            ContentDescription(title: "Accomplishment:",description: "Knitting and travel \nKnitting and travel and every thing \nKnitting and travel and every thing \nKnitting and travel and every thing \nKnitting and travel and every thing "),
            ProfileImage()
          ],
        ),
      ),
    );
  }
}
