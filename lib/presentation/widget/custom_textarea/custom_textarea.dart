import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextarea extends StatefulWidget {
  const CustomTextarea({super.key, required this.placeholder, required this.setText, this.text});
  final String placeholder;
  final Function(String) setText;
  final String ? text;

  @override
  State<CustomTextarea> createState() => _CustomTextareaState();
}

class _CustomTextareaState extends State<CustomTextarea> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    if(widget.text!=null)
    textEditingController.text = widget.text!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.placeholder,
              style: GoogleFonts.baloo2(
                textStyle:TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white
                ),)),
        ),
        Container(
          margin: EdgeInsets.all(8),
          width: double.infinity, // <-- TextField width
          height: 120, // <-- TextField height
          padding: EdgeInsets.all(4),
          child: TextField(
            controller: textEditingController,
            cursorColor: Colors.yellow.shade600,
            maxLines: null,
            expands: true,
            style: GoogleFonts.poppins(
              textStyle:TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white
              ),),
            keyboardType: TextInputType.multiline,
            onChanged: (value){
              widget.setText(value);
            },
            decoration: InputDecoration.collapsed(filled: true, hintText: 'Enter a message',
              fillColor: Color.fromRGBO(0, 0, 0, 0),
              hintStyle:GoogleFonts.baloo2(
                textStyle:TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white
                ),),
            ),
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1,color: Colors.yellow.shade600),
          ),
        ),
      ],
    );
  }
}
