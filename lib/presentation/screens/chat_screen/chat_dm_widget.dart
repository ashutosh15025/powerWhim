import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/service_api_constant.dart';

class ChatDmWidget extends StatefulWidget {
  const ChatDmWidget({super.key, required this.name, required this.lastMessage, required this.count, required this.time});
  final String name;
  final String ? lastMessage;
  final String ? count;
  final DateTime ? time;

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
                Text(widget.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: green
                ),),
                Visibility(
                  visible:widget.count!=null&&int.parse(widget.count!)>0?true:false ,
                  child: Container(
                    height: 25,
                       padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                       decoration: BoxDecoration(
                           color: green,
                           border: Border.all(color: green),
                           borderRadius: BorderRadius.circular(20),
                       ),
                      child: Center(child: Text(widget.count!=null&&int.parse(widget.count!)>0?widget.count!:"",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),))),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  child: Text(widget.lastMessage==null?"":widget.lastMessage!,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.yellow.shade600
                    ),),
                  visible: widget.lastMessage==null?false:true,
                ),
                Visibility(
                  visible: widget.time==null ? false:true,
                  child: Text(widget.time==null ? "": getHours(widget.time!),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow.shade600
                    ),),
                )
              ],
            ),
          ),

      Divider(
        color: Colors.yellow.shade600,
        height: 0.2,
        thickness: 0.5,
      )
        ],
      ),
    );
  }
  String getHours(DateTime datetime){
    print(datetime);
    var localTIme = datetime.toLocal();
    String formattedTime = localTIme.toString();
    List<String> parts = formattedTime.split(' ');
    String time = parts[1];
    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(3, 5));
    String amPm = hour < 12 ? "AM" : "PM";
    hour = hour % 12;  // Adjust hour for 12-hour format (12 becomes 12, 13 becomes 1)
    String extractedTime = "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $amPm";
    return extractedTime; // Output: 12:08 PM
  }
}
