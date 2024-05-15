import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/message_widget/my_message_widget.dart';
import '../../widget/message_widget/other_messages.dart';


class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen({super.key});

  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title:Center(
        child: Text("Ashes",
        style: GoogleFonts.baloo2(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white
          )
        ),),
      ),
        backgroundColor: Colors.black,

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(0, 0,0, .9),
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyMessageWidget(),
                OtherMessages(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
