import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/service_api_constant.dart';
import '../../bloc/authbloc/auth_bloc.dart';
import '../gradient_button_green_yelllow.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key,required this.onSignInLogIN});
  final Function() onSignInLogIN;


  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  String ? userEmail= null;

  @override
  Widget build(BuildContext context) {
    var bloc =  BlocProvider.of<AuthBloc>(context);
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromRGBO(31, 31, 31, 1),
      ),
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
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
            TextField(
              enableInteractiveSelection: true,
              cursorColor: Colors.yellow,
              style: TextStyle(color: Colors.white),
              onChanged: (value){
                userEmail = value;
                print(userEmail);
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey,width: 2),
                    borderRadius: BorderRadius.circular(12)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(12)
                ),
                hintText: "Enter Your Email address",
                hintStyle: TextStyle(color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: InkWell(
                 onTap: (){
                   print(userEmail.toString());
                   if(userEmail!=null){
                   bloc.add(RegisterEvent(userEmail!));}
                 },
                  child: GradientButtonGreenYellow(buttonText: "Next")),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("-------------OR-------------",
                style: TextStyle(color: Colors.grey,
                    fontSize: 16),),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Alerady have Account?",
                  style: TextStyle(color: Colors.grey,
                      fontSize: 16),),
                  InkWell(
                    onTap: (){widget.onSignInLogIN();
                    },
                    child: Text("Login",
                      style: GoogleFonts.baloo2(
                        textStyle:TextStyle(color: green,
                          fontSize: 16,
                        fontWeight: FontWeight.w500),)),
                  )]
            ),

          ],
        ),
    );
  }
}
