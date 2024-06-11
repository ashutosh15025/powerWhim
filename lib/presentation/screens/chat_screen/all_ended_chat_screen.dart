import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/screens/chat_screen/personal_chat_screen.dart';
import 'package:powerwhim/presentation/screens/chat_screen/start_chat_end_chat_widget.dart';

import '../../../constant/service_api_constant.dart';
import '../../../constant/string_constant.dart';
import '../../../data/model/chats/chats_details_model.dart';
import '../../bloc/chatbloc/chat_bloc.dart';
import '../../widget/custom/custom_circular_loading_bar.dart';
import '../../widget/error/custom_error_widget.dart';
import 'chat_dm_widget.dart';

class AllEndedChatScreen extends StatefulWidget {
  const AllEndedChatScreen({super.key});

  @override
  State<AllEndedChatScreen> createState() => _AllEndedChatScreenState();

}

class _AllEndedChatScreenState extends State<AllEndedChatScreen> {
  ChatsDetailsModel? chatsDetailsModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetChatsSuccessState) {
          chatsDetailsModel = state.chatsDetailsModel;
          if (chatsDetailsModel != null &&
              chatsDetailsModel!.data != null &&
              chatsDetailsModel!.data!.chats!.length >= 0)
            return PopScope(
              canPop: true,
              onPopInvoked: (bool didPop) async {
                BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(1));
                // Action to perform on back pressed
              },
              child: Scaffold(
                appBar:  AppBar(
                    iconTheme: IconThemeData(
                      color: Colors.white, //change your color here
                    ),
                  centerTitle: true,
                  title: Text("All Chats",
                      style: GoogleFonts.baloo2(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )),
                  backgroundColor: Colors.black,
                ),
                body: chatsDetailsModel!.data!.chats!.length > 0?Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color.fromRGBO(0, 0, 0, .95),
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
                                              previousScreen: "AllEndedChatScreen",
                                              deactivate_on: chatsDetailsModel!
                                                  .data!.chats![index]!
                                                  .deactivateOn,
                                          )));
                              BlocProvider.of<ChatBloc>(context).add(
                                  GetPersonalChatEvent(
                                      chatId: chatsDetailsModel!.data!
                                          .chats![index]!.chatId!,
                                      page: 0));
                            },
                            child: ChatDmWidget(
                              name: chatsDetailsModel!.data!.chats![index]
                                  .userName == null
                                  ? "ashes"
                                  : chatsDetailsModel!.data!.chats![index]
                                  .userName!,
                              lastMessage:
                              chatsDetailsModel!.data!.chats![index]
                                  .lastConversations,
                              count: chatsDetailsModel!.data!
                                  .chats![index].unreadCount,
                              time: chatsDetailsModel!.data!.chats![index]
                                  .updatedOn,
                            ));;
                      }),
                ): Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      color: Colors.black,
                      child: InkWell(
                        onTap: () {
                        },
                        child: Center(
                          child: Text(StringConstant.noInactiveChats,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),),
                        ),
                      ),
                    ),
                    InkWell(
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
                              .inactiveChats!} Unread Chat please check",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            );
        } else if (state is ErrorState) {
          return Scaffold(
            body: Container(
              color: Colors.black,
              child: CustomErrorWidget(
                error: true,
                closeErrorWidget: () {
                  BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(0));
                },
                mssg: ERROR,
              ),
            ),
          );
        }
        else if(state is GetStartEndChatsState){
          BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(0));
        }
        return CustomCircularLoadingBar();
      },
    );
  }

}
