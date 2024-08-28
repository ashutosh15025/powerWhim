import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/color_constant.dart';
import 'package:powerwhim/constant/full_profile_privious_screen.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/custom/friend_dm_widget.dart';
import 'package:powerwhim/presentation/widget/custom/gradient_button_green_yelllow.dart';

import '../../data/model/chats/friends_model.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key, required this.addProfile});
  final Function()  addProfile;

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {

  String eventText = "";
  String eventUserName="";
  bool eventWidgetVisibility = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is GetFullProfileSuccessState)
          Navigator.of(context).pushNamed('/profile',
              arguments: FullProfilePriviousScreen(
                  state.fullProfile, 'FriendsScreen'));
      },
      builder: (context, state) {
        if (state is GetFriendsSuccessState) {
          List<Friend> friendList = [];
          if(state.friendsModel!.data!.friends!=null)
          friendList = state.friendsModel!.data!.friends!;
          if(friendList.length>0)
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Color.fromRGBO(0, 0, 0, .99),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 0,
                  child: ListView.builder(
                    itemCount: friendList.length,
                    itemBuilder: (context, index) {
                      Friend friend = friendList[index];
                      return FriendDmWidget(
                          name: friend.userName!=null?friend.userName!:"Name",
                          description: friend.description,
                          userId: friend.userId!=null?friend.userId!:"userid",
                          chatId: friend.chatId!=null?friend.chatId!:"chatid",
                          deactivate_on: friend.deactivateOn,
                          event:friend.event,
                        profileUpdated:friend.profileUpdated,
                        showEventWidget: showEventWidget,
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: eventWidgetVisibility,
                child: Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventUserName +" Event",
                        style: GoogleFonts.baloo2(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: themeColorLight,
                          ),
                        ),
                      ),
                      SizedBox(height: 8), // Adding some spacing between the title and content
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 150, // Set the max height for the text
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                           eventText,
                            style: GoogleFonts.baloo2(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16), // Adding some spacing before the button
                      InkWell(
                        onTap: () {
                          setState(() {
                            eventWidgetVisibility = false;
                          });
                        },
                        child: GradientButtonGreenYellow(buttonText: 'Cancel'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
          else{
            return Container(
              height:5*MediaQuery.of(context).size.height/6,
              color: Colors.black,
              child: InkWell(
                onTap: (){
                  widget.addProfile();
                },
                child: Center(
                  child: Text("+Add Friends",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),),
                ),
              ),
            );
          }
        } else
          return CustomCircularLoadingBar();
      },
    );
  }


  void showEventWidget(String name, String event){
    eventUserName = name;
    eventText = event;
    setState(() {
      eventWidgetVisibility = true;
    });

  }
}
