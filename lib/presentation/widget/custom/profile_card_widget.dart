import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';

import '../../../constant/color_constant.dart';
import '../../../constant/service_api_constant.dart';
import '../../screens/OthersProfileScreen.dart';
import '../../screens/my_profile_widget.dart';

class ProfileCardWidget extends StatefulWidget {
  const ProfileCardWidget({super.key, required this.name, required this.age, required this.sport, required this.hobbies, required this.userId});
  final String ? name;
  final int ? age;
  final String ? sport;
  final String ? hobbies;
  final String ? userId;

  @override
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
       BlocProvider.of<ProfileblocBloc>(context).add(getFullProfileEvent(widget.userId!));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Row(
                children: [
                  Container(
                    constraints:BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width- MediaQuery.of(context).size.width/4
                    ),
                    child: Text(widget.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                     textStyle:TextStyle(
                      color: green,
                      fontSize: 18,
                        fontWeight: FontWeight.w700
                    ),)),
                  ),
                  Spacer(),
                  Text(widget.age!.toString() + "Yrs",
                    style:  GoogleFonts.poppins(
                      textStyle:TextStyle(
                        color: green,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),))
                ],
              ),
            ),
            widget.sport!=null?Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sports: ",
                  style:  GoogleFonts.poppins(
                    textStyle:TextStyle(
                      color: Colors.yellow.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),)),
                Expanded(
                  child: Text(widget.sport!,
                      maxLines: 4,
                      style:  GoogleFonts.baloo2(
                    textStyle:TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),)),
                )
              ],
            ):SizedBox.shrink(),
            widget.hobbies!=null?Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hobbies: ",
                    style:  GoogleFonts.baloo2(
                      textStyle:TextStyle(
                          color: Colors.yellow.shade500,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),)),
                Expanded(
                  child: Text( widget.hobbies!,
                      maxLines: 4,
                      style:  GoogleFonts.baloo2(
                        textStyle:TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),)),
                )
              ],
            ):SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin:  EdgeInsets.fromLTRB(0, 6, 0, 6),
                  padding:  EdgeInsets.fromLTRB(30, 6, 30, 6),
                  child: InkWell(
                    onTap: (){
                       print("api clicked");
                      BlocProvider.of<ProfileblocBloc>(context).add(getFullProfileEvent(widget.userId!));
                    },
                    child: Text("View",
                    style:  GoogleFonts.baloo2(
                      textStyle:TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      )),),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(colors: [
                      themeColorSecond,
                      themeColor,
                      themeColorLight
                      ]),
                      )
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
