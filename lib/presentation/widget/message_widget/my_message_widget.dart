import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/color_constant.dart';

class MyMessageWidget extends StatelessWidget {
  const MyMessageWidget({super.key, required this.message, required this.time, this.image});
  final String ? message;
  final String time;
  final String ? image;

  @override
  Widget build(BuildContext context) {
    return   ChatBubble(
      shadowColor: Colors.transparent,
      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: themeColor,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
             image==null?SizedBox.shrink():Visibility(
                visible: image!=null,
                child: Container(
                  color: Colors.grey,
                  width: 400,
                  height: 200,
                  child: Image.network(
                    "https://whim.ams3.digitaloceanspaces.com/"+
                        image!,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 400,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.yellowAccent,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ),
            message==null?SizedBox.shrink():Text(
              message!,
              style: GoogleFonts.baloo2(
                textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),
              ),
            ),
            Text(
              time,
              style: TextStyle(color: Colors.white,fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
