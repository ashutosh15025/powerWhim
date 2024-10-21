import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key, required this.visibility, required this.profiles});
  final bool visibility;
  final List<String>? profiles;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
      child: GridView.builder(
        itemBuilder: (BuildContext context,int index){
          return Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://whim.ams3.digitaloceanspaces.com/"+widget.profiles![index]),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect( // make sure we apply clip it properly
              child: BackdropFilter(
                filter: widget.visibility?ImageFilter.blur(sigmaX: 0, sigmaY: 0):ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.grey.withOpacity(0.3),
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: widget.profiles==null?0:widget.profiles!.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing:5,
          mainAxisSpacing: 5,
        ),

      ),
    );;
  }
}
