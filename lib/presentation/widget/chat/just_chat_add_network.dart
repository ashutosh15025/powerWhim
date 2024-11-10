import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/color_constant.dart';

Widget JustChatAddNetwork(BuildContext context,String name){
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('${name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.white),),
      backgroundColor: Colors.black,
      leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
    ),
    body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(18)
        ),
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Choose an option below to proceed:", style: GoogleFonts.poppins(
                textStyle:TextStyle( color: Colors.white,
              fontWeight: FontWeight.bold,fontSize: 20,)),textAlign:TextAlign.center,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                   width: MediaQuery.of(context).size.width/2-40,
                   padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: themeColorLight,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: TextButton(onPressed: (){}, child: Text('Just Chat',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),)),
                Container(
                    width: MediaQuery.of(context).size.width/2-40,
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: TextButton(onPressed: (){}, child: Text('Add To Network',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)))
              ],
            )
          ],
        ),
      ),
    ),
  );
}