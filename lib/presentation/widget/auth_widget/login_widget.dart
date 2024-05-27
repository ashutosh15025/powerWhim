import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/bloc/authbloc/auth_bloc.dart';

import '../../../constant/service_api_constant.dart';
import '../custom/gradient_button_green_yelllow.dart';
import '../custom/password_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key, required this.signInLogin});
  final Function() signInLogin;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String ? password;
  String ? email;
  String ? error;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromRGBO(31, 31, 31, 1),
      ),

      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text("Exchange perspective online for quality time offline ",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)
              ),
              textAlign: TextAlign.center,),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: TextField(
              enableInteractiveSelection: true,
              cursorColor: Colors.yellowAccent,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: error==null?Colors.grey:Colors.redAccent,width: 1),
                    borderRadius: BorderRadius.circular(12)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: error==null?Colors.white:Colors.redAccent,width: 1),
                    borderRadius: BorderRadius.circular(12)
                ),
                hintText: "Enter Your Email address",
                hintStyle: TextStyle(color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ),
              onChanged: (newValue){
                email = newValue;
                setState(() {
                  error = null;
                });
              },
            ),
          ),
          PasswordWidget(setpassword: (String val) {
            password = val;
            error = null;
          },
          error: error,),
          Container(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: (){
                widget.signInLogin();
              },
              child: Text("Forget password?", style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
                textAlign: TextAlign.center,),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(8, 24, 8, 24),
              child: InkWell(
                  onTap: (){
                    if(email!=null && password!=null)
                    BlocProvider.of<AuthBloc>(context).add(LoginEvent(email!, password!));
                    else{
                      setState(() {
                        error = "email and pass cant be empty";
                      });
                    }
                  },
                  child: GradientButtonGreenYellow(buttonText: "Login"))),
          Text("-------------OR-------------",
            style: TextStyle(color: Colors.grey,
                fontSize: 18),),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Dont have an account?",
                style: TextStyle(color: Colors.grey,
                    fontSize: 16),),
                InkWell(
                  onTap: (){
                    widget.signInLogin();
                  },
                  child: Text("Create Account.",
                    style: TextStyle(color: green,
                        fontSize: 16),),
                )]


          )

        ],
      ),
    );
  }
}
