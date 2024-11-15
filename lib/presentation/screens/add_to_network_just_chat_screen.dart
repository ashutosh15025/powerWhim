import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';

import '../../constant/color_constant.dart';
import 'chat_screen/personal_chat_screen.dart';

class AddToNetworkJustChatScreen extends StatefulWidget {
  const AddToNetworkJustChatScreen({super.key, required this.name, required this.userId, required this.previousScreen});
  final String name;
  final String userId;
  final String previousScreen;

  @override
  State<AddToNetworkJustChatScreen> createState() => _AddToNetworkJustChatScreenState();
}

class _AddToNetworkJustChatScreenState extends State<AddToNetworkJustChatScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.userId);
    return BlocListener<ChatBloc, ChatState>(
  listener: (context, state) {
    if(state is SetChatsSuccessState){
      print(state.addChatModel.data!.chatId!);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => PersonalChatScreen(
            chatId: state.addChatModel.data!.chatId!,
            name: widget!.name==null?"":widget!.name,
            previousScreen: widget.previousScreen,
            deactivate_on:  null,
            userId: widget!.userId,
            connectionId: state.addChatModel.data!.connectionStatus,
          )));
      BlocProvider.of<ChatBloc>(context)
          .add(GetPersonalChatEvent(chatId: state.addChatModel.data!.chatId!,page: 0));

    }
    
  },
  child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.white),),
        backgroundColor: Colors.black,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.black
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(18)
          ),
          height: 300,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/icon/message_lottie.json')
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Choose an option below to proceed:", style: GoogleFonts.poppins(
                    textStyle:TextStyle( color: Colors.white,
                      fontWeight: FontWeight.bold,fontSize: 20,)),textAlign:TextAlign.center,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width/2-40,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: themeColorLight,
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: TextButton(onPressed: (){
                        BlocProvider.of<ChatBloc>(context).add(SetChatEvent(USER_ID!,widget.userId,0));
                      }, child: Text('Just Chat',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),)),

                  Container(
                      width: MediaQuery.of(context).size.width/2-40,
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: TextButton(onPressed: (){
                        BlocProvider.of<ChatBloc>(context).add(SetChatEvent(USER_ID!,widget.userId,1));
                      }, child: Text('Add To Network',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)))
                  
                ],
              )
            ],
          ),
        ),
      ),
    ),
);;
  }
}
