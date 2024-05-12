import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authbloc/auth_bloc.dart';
import '../gradient_button_green_yelllow.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key,required this.onPressNextButton});
  final Function() onPressNextButton;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


  @override
  Widget build(BuildContext context) {
    var bloc =  BlocProvider.of<AuthBloc>(context);
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromRGBO(17, 17, 17, 1),
      ),
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("My name is hada isjjnjnn?",
                style: TextStyle(color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),),
            ),
            TextField(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: InkWell(
                 onTap: (){
                   bloc.add(RegisterSucessEvent());
                   widget.onPressNextButton();

                 },
                  child: GradientButtonGreenYellow(buttonText: "Next")),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("-------------OR-------------",
                style: TextStyle(color: Colors.grey,
                    fontSize: 18),),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Alerady have Account?",
                  style: TextStyle(color: Colors.grey,
                      fontSize: 16),),
                  Text("Login?",
                    style: TextStyle(color: Colors.green.shade800,
                        fontSize: 16),)]


            ),

          ],
        ),
    );
  }
}
