import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powerwhim/constant/color_constant.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';

import '../../../constant/service_api_constant.dart';
import '../../bloc/chatbloc/personal_chat_bloc.dart';

class StartChatEndChatWidget extends StatefulWidget {
  const StartChatEndChatWidget({super.key, required this.name, required this.lastMessage, required this.count, required this.time, this.start, this.chatId});
  final String name;
  final String ? lastMessage;
  final String ? count;
  final DateTime ? time;
  final bool ? start;
  final String ?chatId;


  @override
  State<StartChatEndChatWidget> createState() => _StartChatEndChatWidgetState();
}

class _StartChatEndChatWidgetState extends State<StartChatEndChatWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 16, 0,0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              children: [
                Container(
                  constraints : BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width-200
                  ),
                  child: Text(widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: green
                    ),),
                ),
                const Spacer(),
                Visibility(
                  visible:widget.count!=null&&int.parse(widget.count!)>0?true:false ,
                  child: Container(
                      height: 25,
                      width: 25,
                      padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                      decoration: BoxDecoration(
                        color: green,
                        border: Border.all(color: green),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text(widget.count!=null&&int.parse(widget.count!)>0?widget.count!:"",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                        ),))),
                ),
                InkWell(
                  onTap: (){
                   BlocProvider.of<PersonalChatBloc>(context).add(GetStartEndChatsEvent(USER_ID!, widget.chatId!, block: 0,addToNetwork: 0));
                  },
                  child: true==true?const Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Icon(
                      Icons.add_circle_outlined,
                      color: themeColor,
                    ),
                  ):const Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Icon(
                      Icons.cancel_rounded,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width-200
                    ),
                    child: Text(widget.lastMessage==null?"":widget.lastMessage!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.yellow.shade600
                      ),),
                  ),
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
