import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';

import '../../../constant/service_api_constant.dart';
import '../../screens/chat_screen/personal_chat_screen.dart';

class FriendDmWidget extends StatelessWidget {
  const FriendDmWidget({super.key, required this.name, required this.description, required this.userId, required this.chatId});
  final String name;
  final String description;
  final String userId;
  final String chatId;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(

              children: [
                Container(
                  width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width/4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.baloo2(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.yellow.shade600,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                      Text(
                        description,
                        style: GoogleFonts.baloo2(
                            textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.yellow.shade600,
                                fontWeight: FontWeight.w400

                            )
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                    onTap:(){
                      BlocProvider.of<ChatBloc>(context).add(GetFullProfileEvent(userId!));
                    },
                    child: Icon(Icons.visibility,color: green,)),
                Icon(Icons.messenger_outline,color: green,),
                InkWell(
                    onTap: (){
                      print(chatId +"chatId");
                      BlocProvider.of<ChatBloc>(context).add(GetPersonalChatEvent(chatId));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>  PersonalChatScreen(chatId: chatId,name: name,previousScreen: "FriendsScreen",)));
                    },
                    child: Icon(Icons.message,color: green,))
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
