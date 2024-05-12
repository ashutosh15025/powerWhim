import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class OtherMessages extends StatefulWidget {
  const OtherMessages({super.key});

  @override
  State<OtherMessages> createState() => _OtherMessagesState();
}

class _OtherMessagesState extends State<OtherMessages> {
  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
      backGroundColor: Colors.grey.shade800,
      margin: EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.all(4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),
            ),
            Text(
              "12:00 am",
                style: TextStyle(color: Colors.white)
            )
          ],
        ),
      ),
    );
  }
}
