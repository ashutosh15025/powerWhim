import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powerwhim/constant/full_profile_privious_screen.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/custom/friend_dm_widget.dart';

import '../../data/model/chats/friends_model.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key, required this.addProfile});
  final Function()  addProfile;

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
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
          return Container(
            color: Color.fromRGBO(0, 0, 0, .99),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 0,
              child: ListView.builder(
                itemCount: friendList.length,
                itemBuilder: (context, index) {
                  Friend friend = friendList[index];
                  return FriendDmWidget(
                      name: friend.userName!=null?friend.userName!:"Name",
                      description: friend.description!=null?friend.description!:"description",
                      userId: friend.userId!=null?friend.userId!:"userid",
                      chatId: friend.chatId!=null?friend.chatId!:"chatid",
                      deactivate_on: friend.deactivateOn,
                  );
                },
              ),
            ),
          );
          else{
            return Container(
              height: 2*MediaQuery.of(context).size.height/3,
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
}
