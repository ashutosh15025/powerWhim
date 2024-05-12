import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/content_description_widget.dart';
import '../widget/profile_images_widget.dart';
import 'chat_screen/chat_screen.dart';

class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({super.key});

  @override
  State<MyProfileWidget> createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Jennefer Lucys",
          style: GoogleFonts.lato(
            textStyle:TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white
            ),)
      ),
      backgroundColor: Colors.black,),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        color: Color.fromRGBO(0, 0, 0, 0.9),
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
                ContentDescription(),
                ContentDescription(),
                ContentDescription(),
                ContentDescription(),
                InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const ChatScreen()));
                    },
                    child: ContentDescription()),
                ProfileImages()
              ],
            ),
            ),
      ));
  }
}
