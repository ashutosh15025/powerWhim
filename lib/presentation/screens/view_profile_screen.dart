import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BuildContext, StatelessWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:powerwhim/presentation/widget/custom/list_profile_widget.dart';


class ViewProfilesScreen extends StatelessWidget {
  const ViewProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileblocBloc(),
      child: ListProfileWidget(),
    );
  }
}
