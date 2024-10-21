import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/color_constant.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';

import '../../../constant/service_api_constant.dart';
import '../../screens/chat_screen/personal_chat_screen.dart';

class FriendDmWidget extends StatelessWidget {
  const FriendDmWidget({super.key, required this.name, required this.description, required this.userId, required this.chatId, this.deactivate_on, required this.event, required this.showEventWidget, this.profileUpdated, this.connectionStatus, });
  final String name;
  final String ? description;
  final String userId;
  final String chatId;
  final String ? event;
  final int pageCount = 0;
  final String ? profileUpdated;
  final String ? connectionStatus;
  final Function(String,String) showEventWidget;
  final DateTime ? deactivate_on;

  @override
  Widget build(BuildContext context) {

    print(connectionStatus);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width/3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints:BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width/4,
                        ),
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.baloo2(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.yellow.shade600,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ),
                      ),
                      description!=null?Container(
                        constraints:BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width/4,
                        ),
                        child: Text(
                          description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.baloo2(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.yellow.shade600,
                                  fontWeight: FontWeight.w400

                              )
                          ),
                        ),
                      ):SizedBox.shrink(),
                    ],
                  ),
                ),
                InkWell(
                    onTap:(){
                      BlocProvider.of<ChatBloc>(context).add(GetFullProfileEvent(userId!));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Icon(profileUpdated==null?Icons.visibility:Icons.panorama_fish_eye,color: green,),
                    )),
                InkWell(
                    onTap: (){
                      BlocProvider.of<ChatBloc>(context).add(GetPersonalChatEvent(chatId: chatId,page: pageCount,));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>  PersonalChatScreen(chatId: chatId,name: name,previousScreen: "FriendsScreen",deactivate_on: deactivate_on,userId: userId,presentInNetwork: 1,connectionId: connectionStatus,)));
                    },
                    child: Icon(Icons.message,color: green,)),
                Visibility(
                  visible: event==null?false:true,
                  child: InkWell(
                      onTap:(){
                        showEventWidget(name,event!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Icon(Icons.event,color: green,),
                      )),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.yellow.shade600,
            thickness: .5,
          )
        ],
      );
  }
}
