import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/constant/string_constant.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/screens/chat_screen/all_ended_chat_screen.dart';
import 'package:powerwhim/presentation/screens/chat_screen/personal_chat_screen.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'chat_dm_widget.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.switchAddProfile});
  final Function() switchAddProfile;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver, RouteAware {
  ChatsDetailsModel? chatsDetailsModel;
  IO.Socket? socket;
  ChatBloc? _chatBloc;
  final RouteObserver routeObserver = RouteObserver<PageRoute>();


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(1));
    initSocket();
    super.initState();
  }

  initSocket() {
    socket = IO.io(BASE_URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket?.connect();
    socket?.onConnect((_) {
      setState(() {});
    });
    listenMessage();
    socket?.onDisconnect((_) => print('Connection Disconnection'));
    socket?.onConnectError((err) => print(err));
    socket?.onError((err) => print(err));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatBloc ??= BlocProvider.of<ChatBloc>(context);
  }

  @override
  void dispose() {
    // Unsubscribe from route observer
    routeObserver.unsubscribe(this);
    // Unregister from lifecycle events
    WidgetsBinding.instance.removeObserver(this);
    socket?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {

      BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(1)); // Refresh chat
    } else if (state == AppLifecycleState.paused) {

    }
  }


  // This is called when user returns to this route after popping the next route
  @override
  void didPopNext() {
    BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(1));
  }

  @override
  Widget build(BuildContext context) {
    if (socket != null && socket!.id != null) {
      BlocProvider.of<ChatBloc>(context).add(SetSocketEvent(socket!.id!));
    }
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is GetChatsSuccessState) {
          chatsDetailsModel = state.chatsDetailsModel;
        }
      },
      builder: (context, state) {
        if (state is ErrorState) {
          return Container(
            color: Colors.black,
            child: CustomErrorWidget(
              error: true,
              closeErrorWidget: () {
                BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(1));
              },
              mssg: ERROR,
            ),
          );
        }
        else {
          if (chatsDetailsModel != null && chatsDetailsModel!.data != null &&
              chatsDetailsModel!.data!.chats!.length > 0) {
            return PopScope(
              canPop: true,
              onPopInvoked: (bool didPop) async {
                Navigator.of(context).pop(); // Action to perform on back pressed
              },
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 200),
                  color: Color.fromRGBO(0, 0, 0, .95),
                  child: Column(
                    children: [
                      int.parse(chatsDetailsModel!.data!.inactiveChats!) > 0
                          ? InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  AllEndedChatScreen(
                                  ))).then((_)=>{
                                    BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(1))});
                          BlocProvider.of<ChatBloc>(context).add(
                              GetChatsEvent(0));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 50,
                          color: Color.fromRGBO(255, 255, 17, .2),
                          child: Text(
                            "You Might have ${chatsDetailsModel!.data!
                                .inactiveChats!} Unread Chat please check",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      )
                          : SizedBox.shrink(),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 100,
                        child: ListView.builder(
                            itemCount: chatsDetailsModel!.data!.chats!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                PersonalChatScreen(
                                                  chatId: chatsDetailsModel!
                                                      .data!.chats![index]!
                                                      .chatId!,
                                                  name: chatsDetailsModel!
                                                      .data!.chats![index]!
                                                      .userName!,
                                                  previousScreen: "ChatScreen",
                                                  socketId: socket!.id,
                                                  deactivate_on: null,
                                                  userId: chatsDetailsModel!
                                                      .data!.chats![index]!
                                                      .userId,
                                                  connectionId: chatsDetailsModel!
                                                      .data!.chats![index]!
                                                      .connectionstatus,
                                                ))).then((_)=>{print("privious")});
                                  },
                                  child: ChatDmWidget(
                                    name: chatsDetailsModel!.data!.chats![index]
                                        .userName == null
                                        ? StringConstant.name
                                        : chatsDetailsModel!.data!.chats![index]
                                        .userName!,
                                    lastMessage:
                                    chatsDetailsModel!.data!.chats![index]
                                        .lastConversations,
                                    count: chatsDetailsModel!.data!
                                        .chats![index].unreadCount,
                                    time: chatsDetailsModel!.data!.chats![index]
                                        .updatedOn,
                                  ));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (chatsDetailsModel != null && chatsDetailsModel!.data != null &&
              chatsDetailsModel!.data!.chats!.length == 0) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 5 * MediaQuery
                      .of(context)
                      .size
                      .height / 6,
                  color: Colors.black,
                  child: InkWell(
                    onTap: () {
                      widget.switchAddProfile();
                    },
                    child: Center(
                      child: Text(StringConstant.addChats,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                    ),
                  ),
                ),
                int.parse(chatsDetailsModel!.data!.inactiveChats!) > 0
                    ? InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            AllEndedChatScreen(
                            )));
                    BlocProvider.of<ChatBloc>(context).add(
                        GetChatsEvent(0));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 50,
                    color: Color.fromRGBO(255, 255, 17, .2),
                    child: Text(
                      "You Might have ${chatsDetailsModel!.data!
                          .inactiveChats!} UnViewed Chat please check",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                )
                    : SizedBox.shrink(),
              ],
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }

  void listenMessage() {
    socket!.on('message', (data) {
      String chatId = data['chat_id'];
      if (chatsDetailsModel != null) {
        Chat? newMessageData;
        for (int i = 0; i < chatsDetailsModel!.data!.chats!.length; i++) {
          if (chatsDetailsModel!.data!.chats![i].chatId == chatId) {
            newMessageData = chatsDetailsModel!.data!.chats![i];
            chatsDetailsModel!.data!.chats!.removeAt(i);
            break; // Exit the loop once element is found
          }
        }
        if (newMessageData != null) {
          // Assign message text if it exists
          if (data['message_text'] != null) {
            newMessageData.lastConversations = data['message_text'];
          } else {
            newMessageData.lastConversations = "";
          }

          // Override with photo text if image exists
          if (data['image'] != null) {
            newMessageData.lastConversations = "📷 Photo";
          }

          newMessageData.updatedOn = DateTime.parse(data['message_time']);
          newMessageData.unreadCount =
              (int.parse(newMessageData.unreadCount!) + 1).toString();

          setState(() {
            chatsDetailsModel!.data!.chats!.insert(0, newMessageData!);
          });
        }
      }
    });
  }
}