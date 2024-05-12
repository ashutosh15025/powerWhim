import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/screens/chat_screen/personal_chat_screen.dart';

import 'chat_dm_widget.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();


}

class _ChatScreenState extends State<ChatScreen> {


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        Navigator.of(context).pop(); // Action to perform on back pressed
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Ashutosh",
            style: GoogleFonts.baloo2(
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700
              )
            ),
          ),
          backgroundColor: Colors.black,

        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(0, 0, 0, .9),
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context,index){
                return InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const PersonalChatScreen()));
                    },
                    child: ChatDmWidget());
              }),
        ),
      ),
    );
  }
}
