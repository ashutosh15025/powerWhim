import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatDmWidget extends StatefulWidget {
  const ChatDmWidget({super.key});

  @override
  State<ChatDmWidget> createState() => _ChatDmWidgetState();
}

class _ChatDmWidgetState extends State<ChatDmWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 16, 0,0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.green.shade600
                ),),
                Container(
                  height: 25,
                     padding: EdgeInsets.all(3),
                     decoration: BoxDecoration(
                         color: Colors.black,
                         border: Border.all(color: Colors.yellow.shade600),
                         borderRadius: BorderRadius.circular(20),
                     ),
                    child: Center(child: Text("10",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                    ),)))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("This is my last chat",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.yellow.shade600
                  ),),
                Text("12:00 am",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.yellow.shade600
                  ),)
              ],
            ),
          ),

      Divider(
        color: Colors.yellow.shade700,
        height: 0.9,
      )
        ],
      ),
    );
  }
}
