import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 16, 8, 8),
      child: GridView.builder(
        itemBuilder: (BuildContext context,int index){
          return Container(
            child: Text("",),
            decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/icon/logo.png'),
                )
            ),
          );
        },
        itemCount: 9,
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
