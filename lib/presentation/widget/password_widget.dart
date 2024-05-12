import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({super.key,  this.placeholder="Password"});
  final String placeholder;

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
        style: TextStyle(color: Colors.white),
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
              borderSide: BorderSide(color: Colors.grey,width: 2),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green,width: 2),
              borderRadius: BorderRadius.circular(10)
          ),
          hintText: widget.placeholder,
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
