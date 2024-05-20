import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({super.key,  this.placeholder="Password", required this.setpassword, this.error});
  final String placeholder;
   final Function(String) setpassword;
   final String ? error;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool passwordVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: TextField(
        enableInteractiveSelection: true,
        cursorColor: Colors.yellowAccent,
        style: TextStyle(color: Colors.white),
        onChanged: (value){
          widget.setpassword(value);
        },
        obscureText: !passwordVisibility,
        decoration: InputDecoration(
          suffixIcon: passwordVisibility?InkWell(
              onTap: (){
                setState(() {
                  passwordVisibility=!passwordVisibility;
                });
              },
              child: Icon(Icons.visibility)
          ):
          InkWell(
            onTap: (){
              setState(() {
                passwordVisibility=!passwordVisibility;
              });
            },
            child: Icon(
                Icons.visibility_off
            ),
          ),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color:widget.error == null?Colors.grey:Colors.red,width: 1),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:widget.error == null?Colors.white:Colors.red,width: 1),
              borderRadius: BorderRadius.circular(10)
          ),
          hintText: widget.placeholder,
          hintStyle: GoogleFonts.baloo2(
               textStyle: TextStyle(color: Colors.grey,
               fontWeight: FontWeight.w400)
          ),
        ),
      ),
    );
  }
}
