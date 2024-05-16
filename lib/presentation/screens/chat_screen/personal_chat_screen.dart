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
    List<String> listItem =["ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes"];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text("Ashes",
        style: GoogleFonts.baloo2(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white
          )
        ),
      ),
        backgroundColor: Colors.black,

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(0, 0,0, .9),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                   Container(
                     height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/5,
                     child: ListView.builder(
                         itemCount: listItem.length,
                         itemBuilder: (context,index){
                       if(index%2==0)
                         return MyMessageWidget();
                       else
                         return OtherMessages();
                     }),
                   ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                      child:TextField(
                        cursorColor: Colors.yellow.shade600,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.photo_library_sharp),
                          prefixIconColor: Colors.yellow,
                          suffixIcon: Icon(Icons.send),
                          suffixIconColor: Colors.yellow,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.yellow,width: 1)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.yellow,width: 1)
                          ),
                          hintText: "type here",
                          hintStyle:GoogleFonts.baloo2(
                            textStyle:TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: Colors.white
                            ),),
                        ),
                      ),

                    ),
                  ],
                ),

              ),


            ),
          ],
        ),
      ),
    );
  }
}
