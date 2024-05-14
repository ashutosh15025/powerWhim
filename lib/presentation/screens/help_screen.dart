import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/widget/gradient_button_green_yelllow.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0,0,0,0.95),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text("Get in touch with us today",
              style: GoogleFonts.baloo2(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    cursorColor: Colors.yellow,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow,width: .5),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow,width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: "Enter Your Name",
                      hintStyle: GoogleFonts.baloo2(
                          textStyle: TextStyle(color: Colors.grey,
                              fontWeight: FontWeight.w400)
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    cursorColor: Colors.yellow,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow,width: .5),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow,width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: "Enter Your Name",
                      hintStyle: GoogleFonts.baloo2(
                          textStyle: TextStyle(color: Colors.grey,
                              fontWeight: FontWeight.w400)
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    cursorColor: Colors.yellow,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow,width: .5),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow,width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: "Enter Your Name",
                      hintStyle: GoogleFonts.baloo2(
                          textStyle: TextStyle(color: Colors.grey,
                              fontWeight: FontWeight.w400)
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity, // <-- TextField width
                  height: 120, // <-- TextField height
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(4),
                  child: TextField(
                    cursorColor: Colors.yellow,
                    maxLines: null,
                    expands: true,
                    style: GoogleFonts.baloo2(
                      textStyle:TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white
                      ),),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration.collapsed(filled: true, hintText: 'Enter a message',
                      fillColor: Color.fromRGBO(0, 0, 0, 0),
                      hintStyle:GoogleFonts.baloo2(
                        textStyle:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey
                        ),),
                    ),
                  ),
            
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1,color: Colors.yellow.shade600),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: GradientButtonGreenYellow(buttonText: "Send message"),
                )
            
            
              ],
            ),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, .95),

                borderRadius: BorderRadius.circular(16.0)
            ),
          ),
        ],
      ),
    );
  }
}
