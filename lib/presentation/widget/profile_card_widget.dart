import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/service_api_constant.dart';
import '../screens/my_profile_widget.dart';

class ProfileCardWidget extends StatefulWidget {
  const ProfileCardWidget({super.key});

  @override
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const MyProfileWidget()));
        print("ashes");
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text("Jenny Lucifer",
                style: GoogleFonts.baloo2(
                 textStyle:TextStyle(
                  color: green,
                  fontSize: 20,
                    fontWeight: FontWeight.w700
                ),)),
                Spacer(),
                Text("age",
                  style:  GoogleFonts.baloo2(
                    textStyle:TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  ),))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My name is: ",
                  style:  GoogleFonts.baloo2(
                    textStyle:TextStyle(
                      color: Colors.yellow.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w800
                  ),)),
                Expanded(
                  child: Text(" this is my age ,i am of 30 ",
                      maxLines: 4,
                      style:  GoogleFonts.baloo2(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sports: ",
                    style:  GoogleFonts.baloo2(
                      textStyle:TextStyle(
                          color: Colors.yellow.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                      ),)),
                Expanded(
                  child: Text(" of 30 age",
                      maxLines: 4,
                      style:  GoogleFonts.baloo2(
                        textStyle:TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin:  EdgeInsets.fromLTRB(0, 6, 0, 6),
                  padding:  EdgeInsets.fromLTRB(30, 6, 30, 6),
                  child: Text("View",
                  style:  GoogleFonts.baloo2(
                    textStyle:TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    )),),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                          end: Alignment.centerRight,
                          begin:  Alignment.centerLeft,
                          colors: [Colors.cyan,green,Colors.yellow],
                        stops: [0.1,0.4,1]
                      )
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Divider(
                thickness: 0.3,
                color: Colors.yellow.shade700,
              ),
            )

          ],
        ),
      ),
    );
  }
}
