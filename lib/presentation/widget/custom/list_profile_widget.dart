import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powerwhim/presentation/widget/custom/profile_card_widget.dart';

import '../../../constant/full_profile_privious_screen.dart';
import '../../../constant/service_api_constant.dart';
import '../../../data/model/profilemodel/profiles_model.dart';
import '../../bloc/profilebloc/profilebloc_bloc.dart';
import '../../screens/OthersProfileScreen.dart';

class ListProfileWidget extends StatefulWidget {
  const ListProfileWidget({super.key});

  @override
  State<ListProfileWidget> createState() => _ListProfileWidgetState();
}

class _ListProfileWidgetState extends State<ListProfileWidget> {
  List<Profile> listItem = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileblocBloc>(context).add(getProfilesEvent());

    return BlocConsumer<ProfileblocBloc, ProfileblocState>(
      listener: (context, state) {
        if(state is getProfilesSuccessState){
          if(state.profilesModel.data!=null)
          listItem+= state.profilesModel.data!.profiles!;
          print(listItem.length);
        }
        else if(state is getFullProfileSuccessState){
          print("get full profile");
          if(state.fullProfile!=null)
            print(state.fullProfile.data!.profile!.name);
          Navigator.of(context).pushNamed('/profile',arguments: FullProfilePriviousScreen(state.fullProfile,'viewProfile'));
        }
      },
      builder: (context, state) {
        return Container(
          color: Color.fromRGBO(0, 0, 0, .99),
          child: SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height - 0,
            child: ListView.builder(
              itemCount: listItem.length,
              itemBuilder: (context, index) {
                return ProfileCardWidget(name: listItem[index].name, age: listItem[index].age, sport: listItem[index].sports, hobbies: listItem[index].hobbies,userId: listItem[index].userId,);
              },),
          ),
        );
      },
    );
  }
}
