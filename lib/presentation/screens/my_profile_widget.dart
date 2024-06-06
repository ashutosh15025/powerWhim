import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';

import '../../constant/service_api_constant.dart';
import '../widget/custom/content_description_widget.dart';
import '../widget/custom/profile_images_widget.dart';

class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({super.key});

  @override
  State<MyProfileWidget> createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  bool error = false;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileblocBloc>(context).add(getFullProfileEvent(USER_ID!));
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
             Row(children:[Container(
               padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
               child: Container(
                 width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width/4 ,
                 child: Text(myprofile!.name!=null?myprofile!.name!:"Name",
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                     style: GoogleFonts.poppins(
                       textStyle:TextStyle(
                           fontSize: 22,
                           fontWeight: FontWeight.w600,
                           color: green),)
                 ),
               ),
             ),
               Spacer()
               ,Text(myprofile.age!=null?myprofile.age!.toString()+"Yrs":"age",
                 style: GoogleFonts.poppins(
                   textStyle:TextStyle(
                       fontSize: 22,
                       fontWeight: FontWeight.w600,
                       color: green),),)]),
             myprofile.sports==null?SizedBox.shrink():ContentDescription(title: "Sports:",description: myprofile.sports!=null?myprofile.sports!.toString():"I love every sports"),
             myprofile.hobbies==null?SizedBox.shrink():ContentDescription(title: "Hobbies:",description: myprofile.hobbies!=null?myprofile.hobbies!.toString():"I love every doing everything"),
             myprofile.ambition==null?SizedBox.shrink():ContentDescription(title: "Ambition:",description:  myprofile.ambition!=null?myprofile.ambition!.toString():"I have big ambitions"),
             myprofile.accomplishment==null?SizedBox.shrink():ContentDescription(title: "Accomplishment:",description:  myprofile.accomplishment!=null?myprofile.accomplishment!.toString():"I have manny accomplishment"),
             ProfileImage(visibility: true, profiles: myprofile.photos,)
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
}
