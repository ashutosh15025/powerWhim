import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:powerwhim/presentation/screens/chat_screen/chat_screen.dart';
import 'package:powerwhim/presentation/screens/friend_screen.dart';
import 'package:powerwhim/presentation/screens/help_screen.dart';
import 'package:powerwhim/presentation/screens/my_profile_widget.dart';
import 'package:powerwhim/presentation/screens/view_profile_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../data/model/chats/chats_details_model.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   IO.Socket ? socket;
  var tabsArray = [];
  int _selectedIndex =0;
  ChatsDetailsModel? chatsDetailsModel;



  @override
  void initState() {
    initSocket();
    super.initState();
  }

  initSocket() {
    print("in init ");
    socket = IO.io("http://192.168.29.226:3000", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    tabsArray=[ViewProfilesScreen(),FriendsScreen(),ChatScreen(),MyProfileWidget(),HelpScreen()];
    socket?.connect();
    socket?.onConnect((_) {
      print('Connection established');
      setState(() {

      });
    });
    socket?.onDisconnect((_) => print('Connection Disconnection'));
    socket?.onConnectError((err) => print(err));
    socket?.onError((err) => print(err));
  }


  @override
  void dispose() {
    SOCKET?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(socket!=null&&socket!.id!=null){
      BlocProvider.of<ChatBloc>(context).add(SetSocketEvent(socket!.id!));
    }

    return  Scaffold(
        resizeToAvoidBottomInset : false,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text("Power Whim",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700
              )
            ),),
          ),

        ),
        body: tabsArray[_selectedIndex],
        bottomNavigationBar: Container(
          color: Colors.transparent,
          child: MoltenBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onTabChange: (clickedIndex) {
              setState(() {
                _selectedIndex = clickedIndex;

                if(clickedIndex == 2){
                BlocProvider.of<ChatBloc>(context).add(GetChatsEvent());
                }
                if(clickedIndex == 1){
                  BlocProvider.of<ChatBloc>(context).add(GetChatsEvent());
                }


              });
            },
            barColor: Colors.black12,
            domeCircleColor:Colors.blueGrey,
            tabs: [
              MoltenTab(
                icon: Icon(Icons.home,
                  color:  _selectedIndex==0?Colors.white:Colors.blueGrey,),
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text("Home",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),),
                )
              ),
              MoltenTab(
                icon: Icon(Icons.dashboard_rounded,
                  color:  _selectedIndex==1?Colors.white:Colors.blueGrey,),
                  title: Text("Friends",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),)

              ),
              MoltenTab(
                icon: Icon(Icons.chat,
                  color:  _selectedIndex==2?Colors.white:Colors.blueGrey,),
                  title: Text("Chats",
                    style: GoogleFonts.poppins(
                        color:  _selectedIndex==2?Colors.white:Colors.blueGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),)
              ),
              MoltenTab(
                icon: Icon(Icons.supervised_user_circle_outlined,
                  color:  _selectedIndex==3?Colors.white:Colors.blueGrey,),
                  title: Text("Profile",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),)
              ),
              MoltenTab(
                icon: Icon(Icons.headphones_rounded,
                  color:  _selectedIndex==4?Colors.white:Colors.blueGrey,),
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Text("Help",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),),
                  )

              ),
            ],
          ),
        ),

      );
  }

}
