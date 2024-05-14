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
    return Container(
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
      );
  }
}
