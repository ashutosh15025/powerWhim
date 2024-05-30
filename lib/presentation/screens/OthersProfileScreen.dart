import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';

import '../widget/custom/content_description_widget.dart';
import '../widget/custom/profile_images_widget.dart';
import 'chat_screen/personal_chat_screen.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({super.key, required this.fullProfileModel});
  final FullProfileModel fullProfileModel;

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
  listener: (context, state) {
     if(state is SetChatsSuccessState){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) =>  PersonalChatScreen(chatId: state.chatId,)));
      BlocProvider.of<ChatBloc>(context).add(GetPersonalChatEvent(state.chatId));
      print("message clicked");
     }
  },
  child: Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () {
                BlocProvider.of<ChatBloc>(context).add(SetChatEvent(USER_ID!, widget.fullProfileModel.data!.userId!));
              },
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.black,
        title: Text("Power Whim",
          style: GoogleFonts.baloo2(
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700
              )
          ),)),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        color: Color.fromRGBO(0, 0, 0, 0.95),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children:[Container(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Text(widget.fullProfileModel.data!.name!,
                    style: GoogleFonts.lato(
                      textStyle:TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.green),)
                ),
              ),
                Spacer()
                ,Text(widget.fullProfileModel.data!.age!.toString()+"Yrs",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.green
                  ),)]),
              ContentDescription(title: "Sports:",description: widget.fullProfileModel.data!.sports!),
              ContentDescription(title: "Knitting:",description: widget.fullProfileModel.data!.sports!),
              ContentDescription(title: "Ambition:",description: widget.fullProfileModel.data!.ambition!),
              ContentDescription(title: "Accomplishment:",description: widget.fullProfileModel.data!.sports!),
              ProfileImage()
            ],
          ),
        ),
      ),
    ),
);


  }
}
