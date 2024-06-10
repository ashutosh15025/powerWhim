import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({super.key, required this.title, required this.placeholder, required this.description, required this.updateName, this.error, this.previousvalue});
  final String title;
  final String placeholder;
  final String description;
  final Function(String) updateName;
  final String ? error;
  final String ? previousvalue;

  @override
  State<CustomInputField> createState() => _CustomInputFielsState();
}

class _CustomInputFielsState extends State<CustomInputField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    if(widget.previousvalue!=null)
    textEditingController.text = widget.previousvalue!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: textEditingController,
            onChanged: (value){
              widget.updateName(value);
            },
            cursorColor: Colors.yellow.shade600,
            style: TextStyle(color: widget.error==null?Colors.white:Colors.red),
            decoration: InputDecoration(
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.error==null?Colors.grey:Colors.red,width: 1)
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.error==null?Colors.white:Colors.red,width: 1)
              ),
              hintText: widget.placeholder,
              hintStyle:GoogleFonts.baloo2(
                textStyle:TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: widget.error==null?Colors.white:Colors.red
                ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Text(widget.description,
              style: GoogleFonts.baloo2(
                textStyle:TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 14
              ),)),
          ),
        ],
      ),
    );
  }
}
