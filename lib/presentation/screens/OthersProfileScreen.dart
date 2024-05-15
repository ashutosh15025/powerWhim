import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/content_description_widget.dart';
import '../widget/profile_images_widget.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({super.key});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        title: Text("Power Whim",
          style: GoogleFonts.baloo2(
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700
              )
          ),)),
      body: Container(
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
                    style: GoogleFonts.lato(
                      textStyle:TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.green),)
                ),
              ),
                Spacer()
                ,Text("age",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.green
                  ),)]),
              ContentDescription(title: "Sports:",description: "Football, Hockey"),
              ContentDescription(title: "Knitting:",description: "Knitting and travel"),
              ContentDescription(title: "Ambition:",description: " Run a marathon /n Run a marathon /n Run a marathon /nRun a marathon /n "),
              ContentDescription(title: "Accomplishment:",description: "Knitting and travel"),
              ProfileImage()
            ],
          ),
        ),
      ),
    );


  }
}
