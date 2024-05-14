
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/profile_card_widget.dart';

class ViewProfilesScreen extends StatelessWidget {
  const ViewProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listItem =["ashes","ashes","ashes","ashes","ashes"];
    return  Container(
        color: Color.fromRGBO(0, 0, 0, .99),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 0,
          child: ListView.builder(
          itemCount: listItem.length,
            itemBuilder: (context,index){
            return ProfileCardWidget();
            },),
        ),
      );
  }
}
