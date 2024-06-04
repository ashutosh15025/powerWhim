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
  const ChatScreen({super.key, required this.switchAddProfile});
  final Function() switchAddProfile;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatsDetailsModel? chatsDetailsModel;
  IO.Socket? socket;


  @override
  void initState() {
    print("init run");
    initSocket();
    super.initState();
  }

  initSocket() {
    print("in init ");
    socket = IO.io(BASE_URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket?.connect();
    socket?.onConnect((_) {
      print('Connection established');
      setState(() {});
    });
    listenMessage();
    socket?.onDisconnect((_) => print('Connection Disconnection hhhh'));
    socket?.onConnectError((err) => print(err));
    socket?.onError((err) => print(err));
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print("object");
    if (socket != null && socket!.id != null) {
      BlocProvider.of<ChatBloc>(context).add(SetSocketEvent(socket!.id!));
    }
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {


      },
      builder: (context, state) {
        print("state.runtimeType");
        if (state is GetChatsSuccessState) {
          print("get chat");
          chatsDetailsModel = state.chatsDetailsModel;
          if(chatsDetailsModel !=null && chatsDetailsModel!.data!=null&& chatsDetailsModel!.data!.length>0)
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
                    print("${chatsDetailsModel!.data![index].updatedOn} ashese");
                    return InkWell(
                        onTap: () {
                          print("screenchange");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => PersonalChatScreen(
                                    chatId: chatsDetailsModel!
                                        .data![index]!.chatId!,
                                    name: chatsDetailsModel!
                                        .data![index]!.userName!,
                                   previousScreen: "ChatScreen",
                                   socketId:socket!.id
                                  )));
                          BlocProvider.of<ChatBloc>(context).add(
                              GetPersonalChatEvent(
                                  chatId:chatsDetailsModel!.data![index]!.chatId!,page: 0));
                        },
                        child: ChatDmWidget(
                          name: chatsDetailsModel!.data![index].userName==null?"ashes":chatsDetailsModel!.data![index].userName!,
                          lastMessage:
                              chatsDetailsModel!.data![index].lastConversations,
                          count: chatsDetailsModel!.data![index].unreadCount,
                          time: chatsDetailsModel!.data![index].updatedOn,
                        ));
                  }),
            ),
          );
          else if(chatsDetailsModel !=null && chatsDetailsModel!.data!=null&& chatsDetailsModel!.data!.length==0)
             return Container(
            color: Colors.black,
            child: InkWell(
              onTap: (){
                widget.switchAddProfile();
              },
              child: Center(
                child: Text("+Add Friends and Start chat",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                  ),),
              ),
            ),
          );
        } else if (state is ErrorState) {
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
        return CustomCircularLoadingBar();
      },
    );
  }


  void listenMessage(){
    print("listen1");
    socket!.on('message', (data) {
      print("listennning message"); // Listen for the 'message' event
      String chatId = data['chat_id'];
      print("listenwwwww");

      if (chatsDetailsModel != null) {
        print(chatsDetailsModel!.data!.length);

        print("chat model not null");
        Datum? newMessageData;
        for (int i = 0; i < chatsDetailsModel!.data!.length; i++) {
          if (chatsDetailsModel!.data![i].chatId == chatId) {
            newMessageData = chatsDetailsModel!.data![i];
            chatsDetailsModel!.data!.removeAt(i);
            break; // Exit the loop once element is found
          }
        }
        if (newMessageData != null) {
          print("new message not null");
          newMessageData.lastConversations = data['message_text'];
          newMessageData.updatedOn = data['image'];
          newMessageData.unreadCount =
              (int.parse(newMessageData.unreadCount!) + 1).toString();
          setState(() {
            chatsDetailsModel!.data!.insert(0, newMessageData!);
          });
        }
        print("listenwwwww");

        print(chatsDetailsModel!.data!.length);

      }
      print('Received message: $data'); // Print "hi" on receiving a message
    });



  }


}
