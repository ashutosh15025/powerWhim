import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/screens/chat_screen/personal_chat_screen.dart';
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'chat_dm_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  ChatsDetailsModel? chatsDetailsModel;


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    SOCKET!.on('message', (data) { // Listen for the 'message' event
      String chatId = data['chat_id'];
      if(chatsDetailsModel!=null)
      {
        print("chat model not null");
        Datum ? newMessageData ;
        for (int i = 0; i < chatsDetailsModel!.data!.length; i++) {
          if (chatsDetailsModel!.data![i].chatId == chatId) {
            newMessageData = chatsDetailsModel!.data![i];
            chatsDetailsModel!.data!.removeAt(i);
            break; // Exit the loop once element is found
          }
        }
        if(newMessageData!=null){
          print("new message not null");
          newMessageData.lastConversations = data['message_text'];
          newMessageData.updatedOn = DateTime.now();
          newMessageData.unreadCount = (int.parse(newMessageData.unreadCount!)+1).toString();
          setState(() {
            chatsDetailsModel!.data!.insert(0, newMessageData!);
          });
        }


      }
      print('Received message: $data');// Print "hi" on receiving a message
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(state.runtimeType);
        if (state is GetChatsSuccessState){
          chatsDetailsModel = state.chatsDetailsModel;
          return PopScope(
            canPop: true,
            onPopInvoked: (bool didPop) async {
              Navigator.of(context).pop(); // Action to perform on back pressed
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Color.fromRGBO(0, 0, 0, .95),
              child: ListView.builder(
                  itemCount: chatsDetailsModel!.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>  PersonalChatScreen(chatId: chatsDetailsModel!.data![index]!.chatId!)));
                          BlocProvider.of<ChatBloc>(context).add(GetPersonalChatEvent(chatsDetailsModel!.data![index]!.chatId!));
                        },
                        child: ChatDmWidget(name: chatsDetailsModel!.data![index].userName!,lastMessage: chatsDetailsModel!.data![index].lastConversations,count: chatsDetailsModel!.data![index].unreadCount,time:chatsDetailsModel!.data![index].updatedOn,));
                  }),
            ),
          );
        }
        else if (state is ErrorState) {
          return Container(
            color: Colors.black,
            child: CustomErrorWidget(
              error: true,
              closeErrorWidget: () {
                BlocProvider.of<ChatBloc>(context).add(GetChatsEvent());
              },
              mssg: ERROR,
            ),
          );
        }
        return  CustomCircularLoadingBar();
      },
    );


  }

}
