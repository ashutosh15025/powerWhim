import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../gradient_button_green_yelllow.dart';
import '../password_widget.dart';

class CreatePasswordWidget extends StatefulWidget {
  const CreatePasswordWidget({super.key, required this.onPressCrossButton, required this.onPressVerifyButton});
  final Function() onPressCrossButton;
  final Function() onPressVerifyButton;

  @override
  State<CreatePasswordWidget> createState() => _CreatePasswordWidgetState();
}

class _CreatePasswordWidgetState extends State<CreatePasswordWidget> {
  @override
  Widget build(BuildContext context) {
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
              child: PasswordWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PasswordWidget(placeholder: "Confirm Password"),
            ),
            Container(
                padding: EdgeInsets.all(34),
                child: InkWell(
                  onTap: (){
                    print("verify clicked");
                    widget.onPressVerifyButton();
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
}
