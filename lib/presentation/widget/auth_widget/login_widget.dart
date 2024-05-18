import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../gradient_button_green_yelllow.dart';
import '../password_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key, required this.setLoginPass});
  final Function(String) setLoginPass;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String ? password;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.fromLTRB(4, 16, 4, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromRGBO(17, 17, 17, 1),
      ),

      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text("Exchange perspective online for quality time offline Exchange perspective online for perspective online for quality time offline",
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlign: TextAlign.center,),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey,width: 2),
                    borderRadius: BorderRadius.circular(12)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green,width: 2),
                    borderRadius: BorderRadius.circular(12)
                ),
                hintText: "Enter Your Email address",
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          PasswordWidget(setpassword: (String val) {
            password = val;
             widget.setLoginPass(password!);
          },),
          Container(
            alignment: Alignment.centerRight,
            child: Text("Forget password?", style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16),
              textAlign: TextAlign.center,),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(8, 24, 8, 24),
              child: GradientButtonGreenYellow(buttonText: "Login")),
          Text("-------------OR-------------",
            style: TextStyle(color: Colors.grey,
                fontSize: 18),),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Dont have an account?",
                style: TextStyle(color: Colors.grey,
                    fontSize: 16),),
                Text("Create Account?",
                  style: TextStyle(color: Colors.green.shade800,
                      fontSize: 16),)]


          )

        ],
      ),
    );
  }
}
