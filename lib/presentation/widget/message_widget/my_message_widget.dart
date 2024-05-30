import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/service_api_constant.dart';

class MyMessageWidget extends StatelessWidget {
  const MyMessageWidget({super.key, required this.message, required this.time});
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return   ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: green,
      child: Container(
        padding: EdgeInsets.all(4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: GoogleFonts.baloo2(
                textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),
              ),
            ),
            Text(
              time,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
