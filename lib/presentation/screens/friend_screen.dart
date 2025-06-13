import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/color_constant.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/custom/friend_dm_widget.dart';
import 'package:powerwhim/presentation/widget/custom/gradient_button_green_yelllow.dart';

import '../../constant/service_api_constant.dart';
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
  final ScrollController _listScrollController = ScrollController();




  @override
  void initState() {
    scrollToTop();
    BlocProvider.of<ChatBloc>(context)
        .add(GetFriendsEvent(USER_ID!));
    super.initState();
  }

  void scrollToTop() {
    if (_listScrollController.hasClients) {
      _listScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is GetFriendsSuccessState) {
          print("${state.friendsModel.data!.friends} friends list");
          List<Friend> friendList = [];
          if(state.friendsModel.data!.friends!=null)
          friendList = state.friendsModel.data!.friends!;
          if(friendList.length>0)
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Color.fromRGBO(0, 0, 0, .99),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 0,
                  child:ListView.builder(
                    controller: _listScrollController,
                    itemCount: friendList.length, // Repeat 3 times
                    itemBuilder: (context, index) {
                      final actualIndex = index;
                      Friend friend = friendList[actualIndex];
                      void markAsRead(String ChatId) {
                        friendList[actualIndex].unreadMessages = "0";
                      }
                     print(" ${friend.deactivateOn}  friend.deactivateOn ${friend.userName}");
                      return FriendDmWidget(
                        name: friend.userName ?? "Name",
                        description: friend.description,
                        userId: friend.userId ?? "userid",
                        chatId: friend.chatId ?? "chatid",
                        deactivate_on: friend.deactivateOn,
                        event: friend.event,
                        profileUpdated: friend.profileUpdated,
                        connectionStatus: friend.connectionstatus,
                        showEventWidget: showEventWidget,
                        unreadMessages: friend.unreadMessages,
                        markAsRead: markAsRead,
                      );
                    },
                  )
                  ,
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
