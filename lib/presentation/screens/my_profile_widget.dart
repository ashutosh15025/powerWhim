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
  Widget build(BuildContext context) {
    // BlocProvider.of<ProfileblocBloc>(context).add(getFullProfileEvent(USER_ID!));
    BlocProvider.of<ProfileblocBloc>(context).add(getMyFullProfileEvent(USER_ID!));

    return  BlocConsumer<ProfileblocBloc, ProfileblocState>(
  listener: (context, state) {
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
    print("my profile"+myprofile.photos!.length.toString());
     return Container(
       height: MediaQuery.of(context).size.height,
       padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
       color: Color.fromRGBO(0, 0, 0, 0.95),
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               children: [
                 Text("My Profile2",
                   style: GoogleFonts.poppins(
                       textStyle: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                       )
                   ),),
                 Spacer(),
                 Icon(Icons.edit,color: themeColor,)
               ],
             ),
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
                       color: green),),)]),
             myprofile.sports==null?SizedBox.shrink():ContentDescription(title: "Sports:",description: myprofile.sports!=null?myprofile.sports!.toString():"I love every sports"),
             myprofile.hobbies==null?SizedBox.shrink():ContentDescription(title: "Hobbies:",description: myprofile.hobbies!=null?myprofile.hobbies!.toString():"I love every doing everything"),
             myprofile.ambition==null?SizedBox.shrink():ContentDescription(title: "Ambition:",description:  myprofile.ambition!=null?myprofile.ambition!.toString():"I have big ambitions"),
             myprofile.accomplishment==null?SizedBox.shrink():ContentDescription(title: "Accomplishment:",description:  myprofile.accomplishment!=null?myprofile.accomplishment!.toString():"I have manny accomplishment"),
             ProfileImage(visibility: true, profiles: myprofile.photos,),

             InkWell(
               onTap: (){
                 editProfile(myprofile);
               },
               child: Container(
                 width: MediaQuery.sizeOf(context).width,
                 padding: EdgeInsets.all(8),
                 margin: EdgeInsets.fromLTRB(MediaQuery.sizeOf(context).width/5, 0, MediaQuery.sizeOf(context).width/5, 0),
                 decoration: BoxDecoration(
                     border: Border.all(color: themeColor,width: 1),
                     borderRadius: BorderRadius.circular(16)
                 ),
                 child: Center(
                   child: Text("Edit Profile",
                     style: GoogleFonts.poppins(
                         textStyle: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.w400,
                           color: themeColor,
                         )
                     ),),
                 ),
               ),
             )
           ],
         ),
       ),
     );
   }
   else if(state is getFullProfileSuccessState){
     Profile myprofile = state.fullProfile.data!.profile!;
     return Container(
       height: MediaQuery.of(context).size.height,
       padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
       color: Color.fromRGBO(0, 0, 0, 0.95),
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               children: [
                 Text("My Profile",
                   style: GoogleFonts.poppins(
                       textStyle: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                       )
                   ),),
                 Spacer(),
                 Icon(Icons.edit,color: themeColor,)
               ],
             ),
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
               ,Text(myprofile.age!=null?myprofile.age!.toString()+"Yrs":"age",
                 style: GoogleFonts.poppins(
                   textStyle:TextStyle(
                       fontSize: 22,
                       fontWeight: FontWeight.w500,
                       color: green),),)]),
             myprofile.sports==null?SizedBox.shrink():ContentDescription(title: "Sports:",description: myprofile.sports!=null?myprofile.sports!.toString():"I love every sports"),
             myprofile.hobbies==null?SizedBox.shrink():ContentDescription(title: "Hobbies:",description: myprofile.hobbies!=null?myprofile.hobbies!.toString():"I love every doing everything"),
             myprofile.ambition==null?SizedBox.shrink():ContentDescription(title: "Ambition:",description:  myprofile.ambition!=null?myprofile.ambition!.toString():"I have big ambitions"),
             myprofile.accomplishment==null?SizedBox.shrink():ContentDescription(title: "Accomplishment:",description:  myprofile.accomplishment!=null?myprofile.accomplishment!.toString():"I have manny accomplishment"),
             ProfileImage(visibility: true, profiles: myprofile.photos,),

             InkWell(
               onTap: (){
               },
               child: Container(
                 width: MediaQuery.sizeOf(context).width,
                 padding: EdgeInsets.all(8),
                 margin: EdgeInsets.fromLTRB(MediaQuery.sizeOf(context).width/5, 0, MediaQuery.sizeOf(context).width/5, 0),
                 decoration: BoxDecoration(
                   border: Border.all(color: themeColor,width: 1),
                   borderRadius: BorderRadius.circular(16)
                 ),
                 child: Center(
                   child: Text("Edit Profile",
                   style: GoogleFonts.poppins(
                     textStyle: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       color: themeColor,
                     )
                   ),),
                 ),
               ),
             )
           ],
         ),
       ),
     );
   }
   else{
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
      print(model.photos!.length.toString()+"model photo length");
    },
    );
  }
}
