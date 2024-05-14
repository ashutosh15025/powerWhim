import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:powerwhim/presentation/screens/chat_screen/chat_screen.dart';
import 'package:powerwhim/presentation/screens/help_screen.dart';
import 'package:powerwhim/presentation/screens/my_profile_widget.dart';
import 'package:powerwhim/presentation/screens/view_profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var tabsHeader = [ViewProfilesScreen(),ChatScreen(),MyProfileWidget(),HelpScreen()];
  var tabsArray = [ViewProfilesScreen(),ChatScreen(),MyProfileWidget(),HelpScreen()];
  int _selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset : false,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("Power Whim",
          style: GoogleFonts.baloo2(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700
            )
          ),),
        ),

      ),
      body: tabsArray[_selectedIndex%4],
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: MoltenBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onTabChange: (clickedIndex) {
            setState(() {
              _selectedIndex = clickedIndex;

            });
          },
          barColor: Colors.black12,
          domeCircleColor:Colors.blueGrey,
          tabs: [
            MoltenTab(
              icon: Icon(Icons.home,
                color:  _selectedIndex==0?Colors.white:Colors.blueGrey,),
              title: Text("Home",
                style: GoogleFonts.baloo2(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),)
            ),
            MoltenTab(
              icon: Icon(Icons.groups,
                color:  _selectedIndex==1?Colors.white:Colors.blueGrey,),
                title: Text("Friends",
                  style: GoogleFonts.baloo2(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),)

            ),
            MoltenTab(
              icon: Icon(Icons.chat,
                color:  _selectedIndex==2?Colors.white:Colors.blueGrey,),
                title: Text("Chats",
                  style: GoogleFonts.baloo2(
                      color:  _selectedIndex==2?Colors.white:Colors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),)
            ),
            MoltenTab(
              icon: Icon(Icons.person,
                color:  _selectedIndex==3?Colors.white:Colors.blueGrey,),
                title: Text("Profile",
                  style: GoogleFonts.baloo2(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),)
            ),
            MoltenTab(
              icon: Icon(Icons.headphones_rounded,
                color:  _selectedIndex==4?Colors.white:Colors.blueGrey,),
                title: Text("Help",
                style: GoogleFonts.baloo2(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),)

            ),
          ],
        ),
      ),

    );
  }

}
