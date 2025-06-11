import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powerwhim/constant/color_constant.dart';
import 'package:powerwhim/presentation/widget/custom/profile_card_widget.dart';
import '../../../data/model/profilemodel/profiles_model.dart';
import '../../bloc/profilebloc/profilebloc_bloc.dart';

class ListProfileWidget extends StatefulWidget {
  const ListProfileWidget({super.key});

  @override
  State<ListProfileWidget> createState() => _ListProfileWidgetState();
}

class _ListProfileWidgetState extends State<ListProfileWidget> {
  List<Profile> listItem = [];
  int page = 0;
  bool isLoadingMore = false;
  final ScrollController _controller = ScrollController();
  String searchValue = "";
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: searchValue);
    BlocProvider.of<ProfileblocBloc>(context).add(getProfilesEvent("", 0));
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.pixels >= _controller.position.maxScrollExtent - 300 &&
        !isLoadingMore) {
      setState(() {
        isLoadingMore = true;
        page++;
      });
      BlocProvider.of<ProfileblocBloc>(context).add(getProfilesEvent(searchValue, page));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileblocBloc, ProfileblocState>(
      buildWhen: (previous, current) => current is getProfilesSuccessState,
      listener: (context, state) {
        if (state is getProfilesSuccessState) {
          if (state.profilesModel.data != null) {
            setState(() {
              if (page == 0) {
                listItem = state.profilesModel.data!.profiles ?? [];
              } else {
                listItem.addAll(state.profilesModel.data!.profiles ?? []);
              }
              isLoadingMore = false;
            });
          }
        }
      },
      builder: (context, state) {
        if (state is getProfilesSuccessState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: const Color.fromRGBO(0, 0, 0, .99),
            child: SafeArea(
              child: Column(
                children: [ // Search Field
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 16, 16, 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _searchController,
                      cursorColor: themeColorLight,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          page = 0;
                          listItem.clear();
                          searchValue = value;
                        });
                        context.read<ProfileblocBloc>().add(getProfilesEvent(value, page));
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: listItem.length + (isLoadingMore ? 1 : 0),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == listItem.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.yellowAccent,
                              ),
                            ),
                          );
                        }

                        final item = listItem[index];
                        return ProfileCardWidget(
                          name: item.name,
                          age: getAge(item.dateOfBirth),
                          sport: item.sports,
                          hobbies: item.hobbies,
                          userId: item.userId,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Initial Loading State
          return Container(
            color: const Color.fromRGBO(0, 0, 0, .4),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.yellowAccent,
              ),
            ),
          );
        }
      },
    );
  }

  int getAge(DateTime? birthDate) {
    if (birthDate == null) return 0;
    final DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
