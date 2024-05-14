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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

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
                          fontSize: 14,
                          color: Colors.yellow.shade400
                        )
                      ),
                    ),
                    Text(
                      "Jenny Lucifer",
                      style: GoogleFonts.baloo2(
                          textStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.yellow.shade400
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
          color: Colors.yellow.shade400,
          thickness: .5,
        )
      ],
    );
  }
}