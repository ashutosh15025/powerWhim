import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImages extends StatefulWidget {
  const ProfileImages({super.key});

  @override
  State<ProfileImages> createState() => _ProfileImagesState();
}

class _ProfileImagesState extends State<ProfileImages> {
  List<String> listItem = ["ashes1","annnn","ashes","annnn","ashes","annnn","ashes","annnn","ashes"];
  @override
  Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.fromLTRB(0, 16, 8, 8),
       child: GridView.builder(
        itemBuilder: (BuildContext context,int index){
          return Container(
            child: Text(listItem[index],
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage("https://plus.unsplash.com/premium_photo-1678112180202-cd950dbe5a35?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dXJsfGVufDB8fDB8fHww"),
            ),
            ),
          );
        },
        itemCount: listItem.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing:5,
          mainAxisSpacing: 5,
        ),

           ),
     );
  }
}
