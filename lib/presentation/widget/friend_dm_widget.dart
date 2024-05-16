import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/service_api_constant.dart';

class FriendDmWidget extends StatelessWidget {
  const FriendDmWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(

            children: [
              Container(
                width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width/4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Jenny Lucifer",
                      style: GoogleFonts.baloo2(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.yellow.shade600,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ),
                    Text(
                      "Jenny Lucifer",
                      style: GoogleFonts.baloo2(
                          textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.yellow.shade600,
                              fontWeight: FontWeight.w400

                          )
                      ),
                    )
                  ],
                ),
              ),
              Icon(Icons.visibility,color: green,),
              Icon(Icons.messenger_outline,color: green,),
              Icon(Icons.message,color: green,)
            ],
          ),
        ),
        Divider(
          color: Colors.yellow.shade600,
          thickness: .5,
        )
      ],
    );
  }
}
