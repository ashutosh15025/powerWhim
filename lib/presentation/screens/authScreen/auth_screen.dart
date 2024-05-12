import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widget/auth_widget/create_password_widget.dart';
import '../../widget/auth_widget/signin_widget.dart';
import '../../widget/auth_widget/verify_otp_widget.dart';
import '../add_profile_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthScreen> {
  bool passwordVisibility = false;
  bool showOTPPanel = false;
  bool showConfirmPasswordPanel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
        body:Stack(
          children: [SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 400,
                    child: Image.network("https://plus.unsplash.com/premium_photo-1671017848638-a154949b71e1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8dXJsfGVufDB8fDB8fHw")),
                SignInScreen(onPressNextButton: onPressCrossOTP,),
              ],
            ),
          ),
          Visibility(
            visible: showConfirmPasswordPanel,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: CreatePasswordWidget(onPressCrossButton:onPressCrossPassword,onPressVerifyButton: onPressVerifyPassword,),
            ),
          ),
            Visibility(
              visible: showOTPPanel,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: VerifyOptWidget(onPressCrossButton:onPressCrossOTP,onPressVerifyButton: onPressVerifyOTP,),
              ),
            )
          ]
        ));
  }

  void onPressCrossOTP(){
    setState(() {
      showOTPPanel=!showOTPPanel;
    });
  }
  void onPressVerifyOTP(){
    setState(() {
      print("otppannel");
      showConfirmPasswordPanel=!showConfirmPasswordPanel;
      showOTPPanel=!showOTPPanel;
    });
  }
  void onPressVerifyPassword(){
    setState(() {
      print("showConfirmPasswordPanel");
      showConfirmPasswordPanel=!showConfirmPasswordPanel;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const AddProfileScreen()));

    });
  }
  void onPressCrossPassword(){
    setState(() {
      showConfirmPasswordPanel=!showConfirmPasswordPanel;
    });
  }
}


