import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/screens/authScreen/auth_screen.dart';
import 'package:powerwhim/presentation/screens/chat_screen/chat_screen.dart';
import 'package:powerwhim/presentation/screens/currentLocation/ask_permission.dart';
import 'package:powerwhim/presentation/screens/friend_screen.dart';
import 'package:powerwhim/presentation/screens/help_screen.dart';
import 'package:powerwhim/presentation/screens/my_profile_widget.dart';
import 'package:powerwhim/presentation/screens/view_profile_screen.dart';

import '../data/model/chats/chats_details_model.dart';
import '../domain/service/database/database_service.dart';
import 'bloc/profilebloc/profilebloc_bloc.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void switchToViewProfile(){
    setState(() {
      _selectedIndex = 0;
    });
  }

  var tabsArray=[];


  _HomeState(){
    tabsArray = [ViewProfilesScreen(),FriendsScreen(addProfile: switchToViewProfile,),ChatScreen(switchAddProfile: switchToViewProfile,),MyProfileWidget(),HelpScreen()];
  }

  int _selectedIndex =0;
  ChatsDetailsModel? chatsDetailsModel;



  @override
  void initState() {
    checkPermission(context);
    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (pop){
        SystemNavigator.pop();
      },
      child: Scaffold(
            resizeToAvoidBottomInset : false,
            extendBody: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              automaticallyImplyLeading: false, // Disable back button
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
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              actions: [
                PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.logout,color: Colors.black,),
                              TextButton(
                              onPressed: (){
                                final DatabaseService databaseService = DatabaseService.instance;
                                databaseService.delete(USER_ID!);
                                USER_ID = null;
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AuthScreen()));
                              }, child: Text("Log Out"),),
                          ]
                        )
                      )
                    ])
              ],


            ),
            body: SingleChildScrollView(
              child: tabsArray[_selectedIndex],
            ),
            bottomNavigationBar: Container(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.black,
                child: MoltenBottomNavigationBar(
                  selectedIndex: _selectedIndex,
                  onTabChange: (clickedIndex) {
                    setState(() {
                      _selectedIndex = clickedIndex;

                      if(clickedIndex == 2){
                      BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(1));
                      }
                      if(clickedIndex == 1){
                        BlocProvider.of<ChatBloc>(context).add(GetFriendsEvent(USER_ID!));
                      }
                    });
                  },
                  barColor: Colors.black12,
                  domeCircleColor:Colors.blueGrey,
                  tabs: [
                    MoltenTab(
                      icon: Icon(Icons.home,
                        color:  _selectedIndex==0?Colors.white:Colors.blueGrey,),
                      title: Text("Whim-span",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize:   MediaQuery.of(context).size.width>=414?12:10,
                            fontWeight: FontWeight.w500
                        ),)
                    ),
                    MoltenTab(
                      icon: Icon(Icons.dashboard_rounded,
                        color:  _selectedIndex==1?Colors.white:Colors.blueGrey,),
                        title: Text("Network",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),)

                    ),
                    MoltenTab(
                      icon: Icon(Icons.chat,
                        color:  _selectedIndex==2?Colors.white:Colors.blueGrey,),
                        title: Text("Chats",
                          style: GoogleFonts.poppins(
                              color:  _selectedIndex==2?Colors.white:Colors.blueGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),)
                    ),
                    MoltenTab(
                      icon: Icon(Icons.supervised_user_circle_outlined,
                        color:  _selectedIndex==3?Colors.white:Colors.blueGrey,),
                        title: Text("Profile",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
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
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                          ),),
                        )

                    ),
                  ],
                ),
              ),
            ),

          ),
    );
  }



  void checkPermission(BuildContext context) async{
    print("checkPermission run");
    var permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.whileInUse||permission == LocationPermission.always){


      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );
      BlocProvider.of<ProfileblocBloc>(context).add(setUpMyLocationEvent(position.longitude, position.latitude));
    }
    else{
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AskPermission()));
    }
  }

}
