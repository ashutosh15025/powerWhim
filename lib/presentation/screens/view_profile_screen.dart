import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:powerwhim/presentation/screens/currentLocation/ask_permission.dart';
import 'package:powerwhim/presentation/widget/custom/list_profile_widget.dart';


class ViewProfilesScreen extends StatelessWidget {
  const ViewProfilesScreen({super.key});



  @override
  Widget build(BuildContext context) {
    checkPermission(context);
    return BlocProvider(
      create: (context) => ProfileblocBloc(),
      child: Column(
          children: [
            ListProfileWidget(),
          ]),
    );
  }

  void checkPermission(BuildContext context) async{
    print(" checkPermission run");
    var permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.whileInUse||permission == LocationPermission.always){


        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high
        );
          BlocProvider.of<ProfileblocBloc>(context).add(setUpMyLocationEvent(position.longitude, position.latitude));
    }
    else{
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AskPermission()));
    }
  }
}
