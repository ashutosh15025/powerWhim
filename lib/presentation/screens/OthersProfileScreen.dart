import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/full_profile_privious_screen.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';

import '../widget/custom/content_description_widget.dart';
import '../widget/custom/profile_images_widget.dart';
import 'chat_screen/personal_chat_screen.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({super.key, required this.fullProfilePScreenModel});

  final FullProfilePriviousScreen fullProfilePScreenModel;

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {

  Profile ? fullprofile ;
  int pageCount = 0;
  String ? chatID = null;


  bool errorWidgetVisibility = false;
  String ? errorMssg ="";
  @override
  void initState() {
    if(widget.fullProfilePScreenModel.fullProfileModel!.data!.profile==null||widget.fullProfilePScreenModel.fullProfileModel==null||widget.fullProfilePScreenModel.fullProfileModel.data==null)
      fullprofile =null;
    else{
    fullprofile = widget.fullProfilePScreenModel.fullProfileModel!.data!.profile!;
    if(widget.fullProfilePScreenModel.fullProfileModel!.data!.chatId!=null)
      chatID = widget.fullProfilePScreenModel.fullProfileModel!.data!.chatId!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is SetChatsSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PersonalChatScreen(
                    chatId: state.chatId,
                    name: fullprofile!.name==null?"":fullprofile!.name!,
                    previousScreen: "OthersProfileScreen",
                deactivate_on: state.deactivate_on,
                userId: fullprofile!.userId,
                connectionId:widget.fullProfilePScreenModel.fullProfileModel!.data!.connectionStatus ,
                  )));
          BlocProvider.of<ChatBloc>(context)
              .add(GetPersonalChatEvent(chatId:state.chatId,page: 0));
        }
        else if(state is ErrorState){
          setState(() {
            errorWidgetVisibility = true;
            errorMssg = state.mssg;
          });
      }
      },
      child: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          if (widget.fullProfilePScreenModel.previousScreenName ==
              'viewProfile') {
          } else if (widget.fullProfilePScreenModel.previousScreenName ==
              'FriendsScreen') {
            BlocProvider.of<ChatBloc>(context).add(GetFriendsEvent(USER_ID!));
          } else {
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
                    chatID==null?Icons.add_comment:Icons.message,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (fullprofile!.userId !=
                        null)
                      BlocProvider.of<ChatBloc>(context).add(SetChatEvent(
                          USER_ID!,
                          fullprofile!.userId!));

                  },
                )
              ],
              centerTitle: true,
              backgroundColor: Colors.black,
              title: Text(
                "Power Whim",
                style: GoogleFonts.baloo2(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              )),
          body: Stack(
            children: [Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              color: Color.fromRGBO(0, 0, 0, 0.95),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width/4 ,
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child:fullprofile!.name==null?SizedBox.shrink():Text(
                            fullprofile!.name!,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.green),
                            )),
                      ),
                      Spacer(),
                      fullprofile!.age==null?SizedBox.shrink():Text(
                        "${fullprofile!.age!} Yrs",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      )
                    ]),
                    fullprofile!.sports==null?SizedBox.shrink():ContentDescription(
                        title: "Sports:",
                        description: fullprofile!.sports!),
                    fullprofile!.hobbies==null?SizedBox.shrink():ContentDescription(
                        title: "Hobbies:",
                        description: fullprofile!.hobbies!),
                    fullprofile!.ambition==null?SizedBox.shrink(): ContentDescription(
                        title: "Ambition:",
                        description: fullprofile!.ambition!),
                    fullprofile!.accomplishment==null?SizedBox.shrink():ContentDescription(
                        title: "Accomplishment:",
                        description: fullprofile!.accomplishment!),
                    ProfileImage(visibility:  widget.fullProfilePScreenModel.fullProfileModel!.data!.visibility!,profiles:widget.fullProfilePScreenModel.fullProfileModel!.data!.profile?.photos)
                  ],
                ),
              ),
            ),Visibility(
                visible: errorWidgetVisibility,
                child: CustomErrorWidget(mssg:errorMssg ,error:true ,closeErrorWidget: closeErrorWidget,))],
          ),
        ),
      ),
    );
  }

  void closeErrorWidget(){
    setState(() {
      errorWidgetVisibility = !errorWidgetVisibility;
    });
  }
}
