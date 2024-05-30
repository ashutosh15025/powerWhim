import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';

import '../../../data/model/chats/chats_details_model.dart';
import '../../widget/message_widget/my_message_widget.dart';
import '../../widget/message_widget/other_messages.dart';


class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen({super.key, required this.chatId});
  final String chatId;


  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  List<Message> listItem = [];
  List<Message> traceList = [];


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    SOCKET!.on('message', (data) { // Listen for the 'message' event
      String chatId = data['chat_id'];
      if(chatId==chatId){
        setState(() {
          listItem.add(Message(conversationMessage: data['message_text'],createdOn: DateTime.now(),userId:"data['user_id']" ));
        });
      }
      print('Received message: $data');// Print "hi" on receiving a message
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
    ScrollController _scrollController = new ScrollController();


    var bloc = BlocProvider.of<ChatBloc>(context);
    if(traceList!=bloc.personalChatList){
    listItem = bloc.personalChatList;
    traceList = bloc.personalChatList;
    }
    return BlocConsumer<ChatBloc, ChatState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    if(state is ErrorState){
      return Scaffold(
        body: CustomErrorWidget(error: true,closeErrorWidget: (){
          setState(() {
            BlocProvider.of<ChatBloc>(context).add(GetPersonalChatEvent(widget.chatId));
          });
        },),
      );
    }
    else if(state is GetPersonalChatSuccessState){
      bloc.personalChatList = state.personalChatModel.data!.messages!;
      listItem = bloc.personalChatList;
      String ? inputValue;
      return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){Navigator.pop(context,true);
              SOCKET!.emit("active-time",{"user_id":"$USER_ID","chat_id":"${widget.chatId}"});
            BlocProvider.of<ChatBloc>(context).add(GetChatsEvent());
            }),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          centerTitle: true,
          title: Text("Ashes",
            style: GoogleFonts.baloo2(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white
                )
            ),
          ),
          backgroundColor: Colors.black,

        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(0, 0,0, .9),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Container(
                        height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/5,
                        child: ListView.builder(
                           controller: _scrollController,
                            itemCount: listItem.length,
                            itemBuilder: (context,index){
                              if(USER_ID==listItem[index]!.userId)
                                return MyMessageWidget(message: listItem[index]!.conversationMessage!,time: listItem[index]!.createdOn!.toString());
                              else
                                return OtherMessages(message: listItem[index]!.conversationMessage!,time: listItem[index]!.createdOn!.toString());
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child:TextField(
                          controller: _controller,
                          cursorColor: Colors.yellow.shade600,
                          onChanged: (value){
                            inputValue = value;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.photo_library_sharp),
                            prefixIconColor: Colors.yellow,
                            suffixIcon: InkWell(child: Icon(Icons.send),
                              onTap: (){
                                if(inputValue!=null && inputValue!.isNotEmpty) {
                                  SOCKET?.emit("message", {
                                    "message_text": "$inputValue",
                                    "chat_id": "${widget.chatId}",
                                    "user_id": "$USER_ID"
                                  });
                                }
                              print("send clicked");
                              _controller.clear();





                              },
                            ),
                            suffixIconColor: Colors.yellow,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.yellow,width: 1)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.yellow,width: 1)
                            ),
                            hintText: "type here",
                            hintStyle:GoogleFonts.baloo2(
                              textStyle:TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: Colors.white
                              ),),
                          ),
                        ),

                      ),
                    ],
                  ),

                ),


              ),
            ],
          ),
        ),
      );
    }
    else
      return CustomCircularLoadingBar();
  },
);
  }
}
