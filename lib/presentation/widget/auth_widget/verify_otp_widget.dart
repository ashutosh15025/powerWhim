import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../../bloc/authbloc/auth_bloc.dart';
import '../custom/gradient_button_green_yelllow.dart';

class VerifyOptWidget extends StatefulWidget {
  const VerifyOptWidget({super.key,required this.onPressCrossButton, required this.onPressVerifyButton});
  final Function() onPressCrossButton;
  final Function() onPressVerifyButton;

  @override
  State<VerifyOptWidget> createState() => _VerifyOptWidgetState();
}

class _VerifyOptWidgetState extends State<VerifyOptWidget> {
  @override
  String ? otp;

  Widget build(BuildContext context) {
    var bloc =  BlocProvider.of<AuthBloc>(context);
    return Center(
      child: Container(
        margin: EdgeInsets.all(24),
        width: double.infinity,
        height: MediaQuery.of(context).size.height/3+35,
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
            PinCodeFields(
              length: 4,
              fieldBorderStyle: FieldBorderStyle.square,
              responsive: false,
              fieldHeight:40.0,
              fieldWidth: 40.0,
              borderWidth:1.0,
              activeBorderColor: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(10.0),
              keyboardType: TextInputType.number,
              autoHideKeyboard: false,
              fieldBackgroundColor: Colors.black,
              borderColor: Colors.yellowAccent,
              textStyle: TextStyle(
                fontSize: 30.0,
                 color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              onComplete: (output) {
                otp = output;
              },
            ),
            Text("Please check your email for the OTP.",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Baloo2',
              color: Colors.white
            ),),
            Container(
                padding: EdgeInsets.all(24),
                child: InkWell(
                    onTap: (){
                     print(otp.toString());
                      if(otp!=null)
                        bloc.add(VerifyOTPsEvent(otp!));
                   },
                    child: GradientButtonGreenYellow(buttonText: "Verify",)))
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromRGBO(17, 17, 17, 1),
        ),
      ),
    );
  }
}
