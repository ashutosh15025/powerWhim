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

import '../constant/color_constant.dart';
import '../data/model/chats/chats_details_model.dart';
import '../domain/service/database/database_service.dart';
import 'bloc/profilebloc/profilebloc_bloc.dart';


class Home extends StatefulWidget {
  const Home({super.key, this.indexSelected});
  final int ? indexSelected;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  final DatabaseService databaseService = DatabaseService.instance;


  void switchToViewProfile(){
    setState(() {
      _selectedIndex = 2;
    });
  }

  var tabsArray=[];


  _HomeState(){
    tabsArray = [MyProfileWidget(),FriendsScreen(addProfile: switchToViewProfile,),ViewProfilesScreen(),ChatScreen(switchAddProfile: switchToViewProfile,),HelpScreen()];
  }

  int _selectedIndex =2;
  ChatsDetailsModel? chatsDetailsModel;



  @override
  void initState() {
    databaseService.delete();
    databaseService.addDetails(USER_ID!,"complete");
    if( widget.indexSelected!=null)
    _selectedIndex = widget.indexSelected!;
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
              centerTitle: true,
              title: Text("Power Whim",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700
                )
              ),),
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              actions: [
                PopupMenuButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        side: BorderSide(
                            color: themeColorLight,
                            width: 1
                        )
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Row(
                            children: [
                              Icon(Icons.logout,color: themeColorLight,),
                                Spacer(),
                                TextButton(
                                onPressed: (){
                                  final DatabaseService databaseService = DatabaseService.instance;
                                  databaseService.delete();
                                  USER_ID = null;
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AuthScreen()));
                                }, child: Center(
                                  child: Text("Log Out",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),),
                                ),),
                            ]
                          ),
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
                color: Colors.transparent,
                child: MoltenBottomNavigationBar(
                  selectedIndex: _selectedIndex,
                  onTabChange: (clickedIndex) {
                    setState(() {
                      _selectedIndex = clickedIndex;

                      if(clickedIndex == 3){
                      BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(1));
                      }
                      if(clickedIndex == 1){
                        BlocProvider.of<ChatBloc>(context).add(GetFriendsEvent(USER_ID!));
                      }
                    });
                  },
                  barColor: Colors.grey.shade900,
                  domeCircleColor:Colors.blueGrey,
                  tabs: [
                    MoltenTab(
                        icon: Icon(Icons.supervised_user_circle_outlined,
                          color:  _selectedIndex==0?Colors.white:Colors.blueGrey,),
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
                          child: Text("Profile",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500
                            ),),
                        )
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
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Icon(Icons.home,
                          color:  _selectedIndex==2?Colors.white:Colors.blueGrey,),
                      ),
                      title: Text("Whim-span",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize:   MediaQuery.of(context).size.width>=404?12:10,
                            fontWeight: FontWeight.w500
                        ),)
                    ),
                    MoltenTab(
                      icon: Icon(Icons.chat,
                        color:  _selectedIndex==3?Colors.white:Colors.blueGrey,),
                        title: Text("Chats",
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
