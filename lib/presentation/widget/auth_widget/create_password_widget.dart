import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authbloc/auth_bloc.dart';
import '../custom/gradient_button_green_yelllow.dart';
import '../custom/password_widget.dart';

class CreatePasswordWidget extends StatefulWidget {
  const CreatePasswordWidget({super.key, required this.onPressCrossButton, required this.onPressVerifyButton});
  final Function() onPressCrossButton;
  final Function() onPressVerifyButton;

  @override
  State<CreatePasswordWidget> createState() => _CreatePasswordWidgetState();
}

class _CreatePasswordWidgetState extends State<CreatePasswordWidget> {
  String ? password;
  String ? confPassword;
  String ? error;

  @override
  Widget build(BuildContext context) {
    var bloc =  BlocProvider.of<AuthBloc>(context);
    return  Center(
      child: Container(
        margin: EdgeInsets.all(24),
        width: double.infinity,
        height: MediaQuery.of(context).size.height/2,
        child:  Column(
          children: [
            InkWell(
              onTap: (){
                widget.onPressCrossButton();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.centerRight,
                child: Icon(Icons.cancel_outlined,
                  color: Colors.white,),
              ),
            ),
            Text("Enter OTP",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18
            ),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PasswordWidget(setpassword: setPassword,error:error),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PasswordWidget(placeholder: "Confirm Password",setpassword: confirmPassword,error: error,),
            ),
            Container(
                padding: EdgeInsets.all(34),
                child: InkWell(
                  onTap: (){
                    print("verify clicked $password /+ $confPassword");
                    if(confPassword == password && password!=null)
                    bloc.add(CreatePasswordEvent(password!));
                    else{
                      setState(() {
                        if( password==null)
                          error = "Password is empty";
                          else
                          error = "Password not match";
                      });
                    }
                  },
                    child: GradientButtonGreenYellow(buttonText: "Verify",)
                ))
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromRGBO(17, 17, 17, 1),
        ),
      ),
    );
  }
  void setPassword(String value){
    password = value;
    if(error!=null){
      setState(() {
        error = null;
      });
  }

  }
  void confirmPassword(String value){
    confPassword = value;
    if(error!=null){
      setState(() {
        error = null;
      });
    }
  }
}
