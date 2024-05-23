import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/data/model/add_profile_model.dart';
import 'package:powerwhim/presentation/bloc/authbloc/auth_bloc.dart';
import 'package:powerwhim/presentation/widget/custom_textarea/custom_textarea.dart';
import 'package:powerwhim/presentation/widget/sliders/distance_slider.dart';
import 'package:powerwhim/presentation/widget/sliders/range_slider_value_Indicator.dart';

import '../../constant/service_api_constant.dart';
import '../home.dart';
import '../widget/custom/checkbox_grid_widget.dart';
import '../widget/custom/custom_slider_thumb.dart';
import '../widget/custom/custom_drop_down.dart';
import '../widget/custom/custom_input_Field.dart';
import '../widget/custom/date_picker_widget.dart';
import '../widget/custom/gradient_button_green_yelllow.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  int distance = 10;
  bool noRelaventSport = false;
  String dropdownvalue = "1";
  String? name;
  String? DOB;
  String? accomplishment;
  String? goals;
  String? hobbies;
  String? sports;
  bool loadingState = false;

  String start = "10";
  String end = "28";

  List<String> myList = ["Item 1", "Item 2", "Item 3"];

  List<String> sportsList = [];
  List<String> hobbiesList = [];

  String selectedValue = "Option 1";

  final List<String> selectedItem = [];

  List<String> weekelyAvailability = List<String>.filled(14, "true");


  String ? errorName = null;
  String ? errorDOB = null;


  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AddProfileSuccessState)
            {
              print("add profile Sucess");
              loadingState = !loadingState;
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
            }
          else{
            loadingState = !loadingState;
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: false,
            appBar: AppBar(
              title: Center(
                child: Text("Add Profile",
                    style: GoogleFonts.baloo2(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              backgroundColor: Colors.black,
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                children: [
                  Container(
                  padding: EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height - 0,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInputField(
                          title: "Name",
                          placeholder: "Enter Your Name",
                          description: "If you dont want people guessing",
                          updateName: setName,
                          error: errorName,
                        ),
                        DatePicker(
                          setDOB: setDOB,
                          error: errorDOB,
                        ),
                        SetAgeRangeSlider(
                          setageRange: setAgeRange,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Estimated weekly availability",
                              style: GoogleFonts.baloo2(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              )),
                        ),
                        SizedBox(
                            child: Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          child: CheckboxGridWidget(
                            weekAvailability: weekAvailability,
                          ),
                        )),
                        DistanceSlider(setDistance: setMeetingDistance,),
                        CustomDropDown(
                            dropDownHeading: "Sports You Participated in",
                            myList: myList,
                            selectedItemFun: setSports),
                        CustomDropDown(
                            dropDownHeading: "Your hobbies",
                            myList: myList,
                            selectedItemFun: sethobbies),
                        CustomTextarea(
                          placeholder: "Your Goal/Ambition",
                          setText: setGoals,
                        ),
                        CustomTextarea(
                          placeholder: "Your Accomplishment",
                          setText: setAccomplishment,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              sports = getListConcatElement(sportsList);
                              hobbies = getListConcatElement(hobbiesList);
                              print(sports);
                              print(hobbies);

                              if (name != null && DOB!=null && name!.isNotEmpty&& DOB!.isNotEmpty) {
                                      onSubmitAllFieldSuccess(context);
                              }
                              else if(name==null || name!.isEmpty){
                                setState(() {
                                  errorName = "Name cant be Empty";
                                });

                              }
                              else{
                                setState(() {
                                  errorDOB = "Date of birth cant be Empty";
                                });
                              }

                            },
                            child: Center(
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: GradientButtonGreenYellow(
                                        buttonText: "Submit"))),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(60)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                  Visibility(
                    visible: loadingState,
                      child: Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ))
                ]
              ),
            ),
          );
        },
      ),
    );
  }

  void setName(String value) {
    name = value;
    setState(() {
      errorName = null;
    });
  }

  void setDOB(String value) {
    DOB = value;
    setState(() {
      errorDOB = null;
    });
  }

  void setAccomplishment(String value) {
    accomplishment = value;
  }

  void setGoals(String value) {
    goals = value;
  }

  void setHobbies(String value) {
    hobbies = value;
  }

  void setSport(String value) {
    sports = value;
  }

  void setMeetingDistance(int val) {
    distance = val;
  }

  void setAgeRange(String startAge, String endAge) {
    start = startAge;
    end = endAge;
  }

  void weekAvailability(List<bool> list) {
    for(int i=0;i<list.length;i++)
      {
        weekelyAvailability[i]=list[i].toString();
      }
  }

  void setSports(List<String> list) {
    sportsList = list;
    print(sportsList.length);
  }

  void sethobbies(List<String> list) {
    hobbiesList = list;
    print(hobbiesList.length);
  }

  String getListConcatElement(List<String> list) {
    String outputString = "";
    for (int i = 0; i < list.length; i++) {
      outputString += list[i];
      if (i != list.length - 1) {
        outputString += " ,";
      }
    }
    return outputString;
  }


  void onSubmitAllFieldSuccess(BuildContext context){
    print("submitcalled");
    BlocProvider.of<AuthBloc>(context).add(
        AddProfileEvent(AddProfileModel(
            name: name,
            dateOfBirth: DOB,
            sports: sports,
            hobbies: hobbies,
            ambition: goals,
            meetingDistance: distance.toString(),
            weekAvailability: weekelyAvailability,
            accomplishment: accomplishment,
            userId:
            USER_ID,
            age: Age(start: start, end: end))));
  }

}
