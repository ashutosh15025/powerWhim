import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/color_constant.dart';
import 'package:powerwhim/data/model/add_profile_model.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/data/model/profilemodel/my_full_profile_model.dart';
import 'package:powerwhim/presentation/bloc/authbloc/auth_bloc.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/custom/gradient_button_green_yelllow.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';

import '../../constant/service_api_constant.dart';
import '../widget/custom/content_description_widget.dart';
import '../widget/custom/profile_images_widget.dart';
import 'add_profile_screen.dart';

class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({super.key});

  @override
  State<MyProfileWidget> createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  bool error = false;
  @override
  void initState() {
    BlocProvider.of<ProfileblocBloc>(context).add(getMyFullProfileEvent(USER_ID!));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ProfileblocBloc, ProfileblocState>(
  listener: (context, state) {
    print("state change");
  },
  builder: (context, state) {
   if(state is getFullProfileFailedState){
     error = true;
     return CustomErrorWidget(error:error , closeErrorWidget: (){
       setState(() {
         error =!error;
       });
     });}
   else if(state is getMyFullProfileSuccessState){
     MyProfile myprofile = state.myFullProfileModel.data!.myProfile!;
     return SingleChildScrollView(
       child: Container(
             padding: EdgeInsets.fromLTRB(16, 0, 16, 100),
             color: Color.fromRGBO(0, 0, 0, 0.95),
             child: SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(children:[Container(
                     padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                     child: Container(
                       width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width/4 ,
                       child: Text(myprofile!.name!=null?myprofile!.name!:"Name",
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                           style: GoogleFonts.poppins(
                             textStyle:TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: green),)
                       ),
                     ),
                   ),
                     Spacer()
                     ,Text(myprofile.dateOfBirth!=null?calculateAgeDOB(myprofile.dateOfBirth!)+"Yrs":"age",
                       style: GoogleFonts.poppins(
                         textStyle:TextStyle(
                             fontSize: 22,
                             fontWeight: FontWeight.w500,
                              color: green),
                        ),
                      )
                    ]),
                   myprofile.event==null?SizedBox.shrink():Row(
                      children: [
                        Text("Event",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: themeColorLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            )),
                        Spacer(),
                        InkWell(
                          onTap: (){
                              BlocProvider.of<ProfileblocBloc>(context).add(setRemoveEventFromProfileEvent());
                          },
                          child:Icon(Icons.delete,
                              color: themeColor),
                        )
                      ],
                    ),
                   myprofile.event==null?SizedBox.shrink():Container(
                      child: Text(myprofile.event!,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    myprofile.sports==null?SizedBox.shrink():ContentDescription(title: "Sports:",description: myprofile.sports!=null?myprofile.sports!.toString():"I love every sports"),
                   myprofile.hobbies==null?SizedBox.shrink():ContentDescription(title: "Hobbies:",description: myprofile.hobbies!=null?myprofile.hobbies!.toString():"I love every doing everything"),
                   myprofile.ambition==null?SizedBox.shrink():ContentDescription(title: "Ambition:",description:  myprofile.ambition!=null?myprofile.ambition!.toString():"I have big ambitions"),
                   myprofile.accomplishment==null?SizedBox.shrink():ContentDescription(title: "Accomplishment:",description:  myprofile.accomplishment!=null?myprofile.accomplishment!.toString():"I have many accomplishment"),
                   ProfileImage(visibility: true, profiles: myprofile.photos,),
                   Row(
       
                     children: [
                       InkWell(
                         onTap: (){
                           editProfile(myprofile);
                         },
                         child: Container(
                           width: MediaQuery.of(context).size.width/2-20,
                           padding: EdgeInsets.all(8),
                           decoration: BoxDecoration(
                               border: Border.all(color: themeColor,width: 1),
                               borderRadius: BorderRadius.circular(8)
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [Text("Edit Profile",
                               style: GoogleFonts.poppins(
                                   textStyle: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.w400,
                                     color: themeColor,
                                   )
                               ),),
                               Icon(Icons.person,color:themeColor)
                             ],
                           ),
                         ),
                       ),
                       InkWell(
                         onTap: (){
                           _showBottomSheet(context);
                         },
                         child: Container(
                           width: MediaQuery.of(context).size.width/2-20,
                           padding: EdgeInsets.all(8),
                           margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
                           decoration: BoxDecoration(
                               border: Border.all(color: themeColor,width: 1),
                               borderRadius: BorderRadius.circular(8)
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [Text("Add Event",
                               style: GoogleFonts.poppins(
                                   textStyle: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.w400,
                                     color: themeColor,
                                   )
                               ),),
                               Icon(Icons.edit,color:themeColor)
                             ],
                           ),
                         ),
                       )
                     ],
                   )
                 ],
               ),
             ),
           ),
     );


   }
   else {
     BlocProvider.of<ProfileblocBloc>(context).add(getMyFullProfileEvent(USER_ID!));
     return CustomCircularLoadingBar();

   }
  },
);
  }

  String calculateAgeDOB(DateTime dob) {
    final today = DateTime.now();
    final difference = today.year - dob.year;

    // Handle cases where DOB is in the future (negative difference)
    if (difference < 0) {
      return "0";
    }

    // Check if birthday has passed in the current year
    bool hasBirthdayPassed = today.month > dob.month ||
        (today.month == dob.month && today.day >= dob.day);

    return  hasBirthdayPassed ? difference.toString() : (difference - 1).toString();
  }
  void editProfile(MyProfile model){
    BlocProvider.of<AuthBloc>(context).add(GetSportEvent());
    BlocProvider.of<AuthBloc>(context).add(GetHobbiesEvent());


    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) =>  AddProfileScreen(name: model.name,DOB:" ${model.dateOfBirth!.year}-${model.dateOfBirth!.month}-${model.dateOfBirth!.day}",ageRange:Age(start: model.ageRange!.start,
        end: model.ageRange!.end) ,distance: model.meetingDistance ,goals:model.ambition,accomplishment:model.accomplishment,sports: model.sports,hobbies: model.hobbies,profile: [...model.photos!],
          weeklyAvailability:[...model.weekAvailability!]
        ))).then((value){
    },
    );
  }
  void _showBottomSheet(BuildContext context) {
    String ? eventText ;
    bool isEmpty = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Colors.grey.shade900,
              ),
              padding: EdgeInsets.only(
                  bottom: MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom),

              child: Container(
                padding: EdgeInsets.all(16),
                child: Wrap(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Add Event",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: themeColorLight
                          ),),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
                          child: TextField(
                            cursorColor: Colors.yellow,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(2),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeColorLight),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: themeColorLight),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              hintText: "Please enter the event you are attending.",
                              hintStyle: GoogleFonts.baloo2(
                                  textStyle: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.w400)
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                isEmpty = false;
                              });
                              eventText = newValue;
                            },
                          ),
                        ),
                        Visibility(
                            visible: isEmpty,
                            child: Text("Event Cant be empty",
                              style: TextStyle(
                                  color: Colors.red,
                                fontSize: 16
                              ),)),
                        InkWell(
                          onTap: () {
                            if (eventText != null){
                              BlocProvider.of<ProfileblocBloc>(context).add(
                                  setEventProfileEvent(eventText!));
                              Navigator.of(context).pop();}
                            else {
                              setState(() {
                                isEmpty = true;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            alignment: Alignment.center,
                            child: Container(
                                width: 200,
                                child: GradientButtonGreenYellow(
                                  buttonText: "Add Event",)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }



}
