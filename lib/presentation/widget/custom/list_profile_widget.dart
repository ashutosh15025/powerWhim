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
  int page = 0;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileblocBloc>(context).add(getProfilesEvent("", 0));
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.atEdge) {
      bool isTop = _controller.position.pixels == 0;
      if (!isTop) {
        //! sign mean bottom
        page++;
        BlocProvider.of<ProfileblocBloc>(context).add(getProfilesEvent("", page));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileblocBloc, ProfileblocState>(
      listener: (context, state) {
        if (state is getProfilesSuccessState) {
          if (state.profilesModel.data != null) {
            setState(() {
              if (page == 0) {
                listItem = state.profilesModel.data!.profiles!;
              } else {
                listItem.addAll(state.profilesModel.data!.profiles!);
              }
            });
          }
        } else if (state is getFullProfileSuccessState) {
          if (state.fullProfile != null) {
            Navigator.of(context).pushNamed('/profile',
                arguments: FullProfilePriviousScreen(
                    state.fullProfile, 'viewProfile'));
          }
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: Color.fromRGBO(0, 0, 0, .99),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(8, 2, 16, 4),
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  height: 50,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        page = 0;
                        listItem.clear();
                      });
                      BlocProvider.of<ProfileblocBloc>(context).add(getProfilesEvent(value, page));
                    },
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 150),
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: listItem.length,
                    itemBuilder: (context, index) {
                      return ProfileCardWidget(
                        name: listItem[index].name,
                        age: getAge(listItem[index].dateOfBirth),
                        sport: listItem[index].sports,
                        hobbies: listItem[index].hobbies,
                        userId: listItem[index].userId,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int getAge(DateTime? birthDate) {
    if (birthDate == null) return 0;
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int monthDifference = currentDate.month - birthDate.month;
    if (monthDifference < 0 ||
        (monthDifference == 0 && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
