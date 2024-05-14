import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/service_api_constant.dart';
import '../screens/OthersProfileScreen.dart';
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
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const OtherProfileScreen()));
        print("ashes");
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Row(
                children: [
                  Text("Jenny Lucifer",
                  style: GoogleFonts.baloo2(
                   textStyle:TextStyle(
                    color: green,
                    fontSize: 20,
                      fontWeight: FontWeight.w700
                  ),)),
                  Spacer(),
                  Text("30 years",
                    style:  GoogleFonts.baloo2(
                      textStyle:TextStyle(
                        color: green,
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                    ),))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Sports: ",
                  style:  GoogleFonts.baloo2(
                    textStyle:TextStyle(
                      color: Colors.yellow.shade400,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),)),
                Expanded(
                  child: Text(" this is my age ,i am of 30 ",
                      maxLines: 4,
                      style:  GoogleFonts.baloo2(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                  ),)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Hobbies: ",
                    style:  GoogleFonts.baloo2(
                      textStyle:TextStyle(
                          color: Colors.yellow.shade400,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),)),
                Expanded(
                  child: Text(" Kniting and travel ",
                      maxLines: 4,
                      style:  GoogleFonts.baloo2(
                        textStyle:TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400
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
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    )),),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(0, 255, 228, 1).withOpacity(.95),
                            Color.fromRGBO(36,134,53,1),
                            Color.fromRGBO(56,164,73,1),
                            Colors.yellow.shade600
                          ],
                          stops: [0,0.5,0.7,1]
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
