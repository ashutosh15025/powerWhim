import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/presentation/widget/gradient_button_green_yelllow.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, this.mssg, required this.error, required this.closeErrorWidget});
  final String ? mssg;
  final bool  error;
  final Function() closeErrorWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, .5),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width- 20,
          padding: EdgeInsets.all(16),
          height: 250,
          child: Column(
            children: [
              error? Icon( Icons.error,
              size: 32,
              color: Colors.redAccent,):Icon( Icons.check_circle,
                size: 50,
                color: green,),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(7.0),
                  child: Text(mssg==null?"some error":mssg!,
                  maxLines: 2,
                    textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                  child: InkWell(
                      onTap: (){
                        closeErrorWidget();
                      },
                      child: GradientButtonGreenYellow(buttonText: "Close")))
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(31, 31, 31, 1)
          ),

        ),
      ),

    );
  }
}
