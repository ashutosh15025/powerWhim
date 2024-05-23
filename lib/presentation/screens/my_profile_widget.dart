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
     FullProfileModel myprofile = state.fullProfile;
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
               child: Text(myprofile.data!.name!=null?myprofile.data!.name!:"Name",
                   style: GoogleFonts.poppins(
                     textStyle:TextStyle(
                         fontSize: 22,
                         fontWeight: FontWeight.w600,
                         color: green),)
               ),
             ),
               Spacer()
               ,Text(myprofile.data!.age!=null?myprofile.data!.age!.toString():"age",
                 style: GoogleFonts.poppins(
                   textStyle:TextStyle(
                       fontSize: 22,
                       fontWeight: FontWeight.w600,
                       color: green),),)]),
             ContentDescription(title: "Sports:",description: myprofile.data!.sports!=null?myprofile.data!.sports!.toString():"I love every sports"),
             ContentDescription(title: "Hobbies:",description: myprofile.data!.hobbies!=null?myprofile.data!.hobbies!.toString():"I love every sports"),
             ContentDescription(title: "Ambition:",description:  myprofile.data!.ambition!=null?myprofile.data!.ambition!.toString():"I love every sports"),
             ContentDescription(title: "Accomplishment:",description:  myprofile.data!.accomplishment!=null?myprofile.data!.accomplishment!.toString():"I love every sports"),
             ProfileImage()
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
