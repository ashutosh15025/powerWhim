import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/data/model/help_model.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';
import 'package:powerwhim/presentation/widget/gradient_button_green_yelllow.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String ? name;
  String ? email;
  String ? phone;
  String ? message;
  String ? errormsg = null;
  String ? successmsg = null;
  String ? error = null;
  bool showError = false;



  bool errorWidget = false;
  String errorapi ="something went wrong";
  @override
  Widget build(BuildContext context) {

    
    return BlocConsumer<ProfileblocBloc, ProfileblocState>(
  listener: (context, state) {
   if(state is getHelpFailedState)
     errormsg = state.mssg;
   else if( state is getHelpSuccessState)
     successmsg = state.mssg;
  errorWidget =!errorWidget;
   print("sucess $successmsg");
   print("error $errormsg");


  },
  builder: (context, state) {
    return Stack(
      children: [
        Container(
        color: Color.fromRGBO(0, 0, 0, 0.95),
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
                            borderSide: BorderSide(
                                color: error==null?Colors.yellow:Colors.redAccent, width: .5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: error==null?Colors.yellow:Colors.redAccent, width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: "Enter Your Name",
                        hintStyle: GoogleFonts.baloo2(
                            textStyle: TextStyle(color: Colors.grey,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                      onChanged:(newValue){
                        name = newValue;
                        error = null;
                        successmsg = null;
                        errormsg = null;
                      },
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
                            borderSide: BorderSide(
                                color: error==null?Colors.yellow:Colors.redAccent, width: .5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: error==null?Colors.yellow:Colors.redAccent, width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: "Enter Your Name",
                        hintStyle: GoogleFonts.baloo2(
                            textStyle: TextStyle(color: Colors.grey,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                      onChanged:(newValue){
                        email = newValue;
                        error = null;
                        successmsg = null;
                        errormsg = null;
                      },
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
                            borderSide: BorderSide(
                                color: error==null?Colors.yellow:Colors.redAccent, width: .5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: error==null?Colors.yellow:Colors.redAccent, width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: "Enter Your Name",
                        hintStyle: GoogleFonts.baloo2(
                            textStyle: TextStyle(color: Colors.grey,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                      onChanged:(newValue){
                        phone = newValue;
                        error = null;
                        successmsg = null;
                        errormsg = null;
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    // <-- TextField width
                    height: 120,
                    // <-- TextField height
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(4),
                    child: TextField(
                      cursorColor: Colors.yellow,
                      maxLines: null,
                      expands: true,
                      style: GoogleFonts.baloo2(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white
                        ),),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration.collapsed(
                        filled: true, hintText: 'Enter a message',
                        fillColor: Color.fromRGBO(0, 0, 0, 0),
                        hintStyle: GoogleFonts.baloo2(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey
                          ),),
                      ),
                      onChanged:(newValue){
                        message = newValue;
                        error = null;
                        successmsg = null;
                        errormsg = null;
                      },
                    ),


                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: error==null?Colors.yellow:Colors.redAccent),
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    child: InkWell(
                      onTap: () {
                        print ("$name $email $phone $message");
                        if (name!=null && name!.isNotEmpty && message!=null && message!.isNotEmpty && phone!=null && phone!.isNotEmpty && email!=null && email!.isNotEmpty){
                          HelpModel helpModel = HelpModel(name: name,emailId: email,mobileNumber: phone,message: message);
                          BlocProvider.of<ProfileblocBloc>(context).add(getHelpEvent(helpModel));
                        }
                        else{
                          setState(() {
                            error = "fill required fields";
                          });
                                print("error +$error");
                        }
                      },
                      child: GradientButtonGreenYellow(
                          buttonText: "Send message"),
                    ),
                  )


                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(31, 31, 31, .95),

                  borderRadius: BorderRadius.circular(16.0)
              ),
            ),
          ],
        ),
      ),
        Visibility(
          visible: errorWidget,
            child: CustomErrorWidget(mssg: errormsg==null?successmsg:errormsg,error:errormsg==null?false!:true, closeErrorWidget: () {
              setState(() {
                errorWidget=!errorWidget ;
              });},))

    ]
    );
  },
);
  }



}
