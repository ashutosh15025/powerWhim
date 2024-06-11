import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/data/model/add_profile_model.dart';
import 'package:powerwhim/presentation/bloc/authbloc/auth_bloc.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:powerwhim/presentation/screens/custom_profile/add_photos_profile.dart';
import 'package:powerwhim/presentation/widget/custom_textarea/custom_textarea.dart';
import 'package:powerwhim/presentation/widget/sliders/distance_slider.dart';
import 'package:powerwhim/presentation/widget/sliders/range_slider_value_Indicator.dart';

import '../../constant/service_api_constant.dart';
import '../home.dart';
import '../widget/custom/checkbox_grid_widget.dart';
import '../widget/custom/custom_drop_down.dart';
import '../widget/custom/custom_input_Field.dart';
import '../widget/custom/date_picker_widget.dart';
import '../widget/custom/gradient_button_green_yelllow.dart';

import 'package:dospace/dospace.dart' as dospace;
import 'package:path/path.dart' as p;

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key, this.name, this.DOB, this.ageRange, this.distance, this.accomplishment, this.goals, this.hobbies, this.sports, this.profile, this.weeklyAvailability});
  final String ? name;
  final String ? DOB;
  final String ? accomplishment;
  final String ? goals ;
  final String ? hobbies ;
  final String ? sports ;
  final List<String> ? profile ;
  final List<bool> ? weeklyAvailability;
  final Age ? ageRange;
  final String ? distance;





  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  int distance = 11;
  bool noRelaventSport = false;
  String dropdownvalue = "1";
  String? name = null;
  String? DOB = null;
  String? accomplishment = null;
  String? goals = null;
  String? hobbies = null;
  String? sports = null;
  bool loadingState = false;
  List<String> profiles = [];
  List<String> oldprofiles = [];

  bool oldProfile = true;


  String start = "18";
  String end = "28";

  List<File> imagesCurrent = [];


  List<String> sportsList = [];
  List<String> hobbiesList = [];



  String selectedValue = "Option 1";

  final List<String> selectedItem = [];

  List<String> weekelyAvailability = List<String>.filled(14, "true");


  String ? errorName = null;
  String ? errorDOB = null;

  @override
  void initState() {
    name = widget.name;
    DOB = widget.DOB;
    goals = widget.goals;
    accomplishment = widget.accomplishment;
    sports = widget.sports;
    hobbies = widget.hobbies;
    if(widget.ageRange!=null){
      start = widget.ageRange!.start.toString();
      end =  widget.ageRange!.end.toString();
    }
    if(widget.distance!=null)
   distance = int.parse(widget.distance!);
    super.initState();
    if(widget.profile!=null){
      oldprofiles = widget.profile!;
    profiles = widget.profile!;}
    if(widget.weeklyAvailability!=null){
      for(var i=0;i<widget.weeklyAvailability!.length;i++){
        if(widget.weeklyAvailability![i])
          weekelyAvailability[i] = "1";
        else
          weekelyAvailability[i] = "0";
      }
     }
  }




  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AddProfileSuccessState)
          {
            loadingState = !loadingState;
            if(widget.name==null)
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
            else{
              BlocProvider.of<ProfileblocBloc>(context).add(getMyFullProfileEvent(USER_ID!));
              Navigator.of(context).pop();}
          }
        else{
          loadingState = !loadingState;
        }
      },
      builder: (context, state) {
        if(state is AddProfileSuccessState){
          return CircularProgressIndicator();
        }
        else{
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: false,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            title: Text("Add Profile",
                style: GoogleFonts.baloo2(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                )),
            centerTitle: true,
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
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInputField(
                        title: "Name",
                        placeholder: "Enter Your Name",
                        description: "If you don't want people guessing use a nick name",
                        updateName: setName,
                        error: errorName,
                          previousvalue:name
                      ),
                      DatePicker(
                        setDOB: setDOB,
                        error: errorDOB,
                        previousvalue: DOB,
                      ),
                      SetAgeRangeSlider(
                        setageRange: setAgeRange,
                        startAge: start,
                        endAge: end,
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
                      DistanceSlider(setDistance: setMeetingDistance,distance: distance,),
                      CustomDropDown(
                          dropDownHeading: "Sports You Participated in",
                          name: "sports",
                          selectedItemFun: setSports,
                      selectedItemString: sports,),
                      CustomDropDown(
                          dropDownHeading: "Your hobbies",
                          name:"hobbies",
                          selectedItemFun: sethobbies,
                      selectedItemString: hobbies,),
                      CustomTextarea(
                        placeholder: "Your Goal/Ambition",
                        setText: setGoals,
                        text: goals,
                      ),
                      CustomTextarea(
                        placeholder: "Your Accomplishment",
                        setText: setAccomplishment,
                        text: accomplishment,
                      ),
                      AddPhotosProfile(getProfile:getProfileImage,previousImages: [...oldprofiles],oldProfile: oldProfile,),
                      Center(
                        child: InkWell(
                          onTap: () async{
                            sports = getListConcatElement(sportsList);
                            hobbies = getListConcatElement(hobbiesList);
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
        };
      },
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
  }

  void sethobbies(List<String> list) {
    hobbiesList = list;
  }

  String? getListConcatElement(List<String> list) {
    String outputString = "";
    for (int i = 0; i < list.length; i++) {
      outputString += list[i];
      if (i != list.length - 1) {
        outputString += " ,";
      }
    }
    if(outputString.isEmpty)
      return null;
    return outputString;
  }


  void onSubmitAllFieldSuccess(BuildContext context)async{
    BlocProvider.of<AuthBloc>(context).add(GetLoadingEvent());
    await uploadfile();
    print("file uploaded");
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
            profileImage: profiles,
            age: Age(start: start, end: end))));
  }


  void getProfileImage(List<File> profile,List<String>previousList){
    profiles = previousList;
    imagesCurrent = profile;
  }


  Future<void> uploadfile() async {
    setState(() {
      oldProfile = false;
    });
    print("upload file");
    dospace.Spaces spaces = new dospace.Spaces(
      region: dotenv.env['REGION'],
      accessKey: dotenv.env['ACCESS_KEY'],
      secretKey: dotenv.env['SECRET_KEY'],
    );
    String? project_name = dotenv.env['PROJECT_NAME'];
    for(int i=0 ;i<imagesCurrent.length;i++) {
      File file = imagesCurrent[i];
      String file_name = file!
          .path
          .split('/')
          .last;
      String time = DateTime.now().toString();
      String charsToRemove = "-.: ";
      String result1 = removeChars(time, charsToRemove);
      try {
        String? etag = await spaces.bucket(project_name).uploadFile(
            USER_ID! + '/' + result1 + '/' + file_name,
            file,
            p.extension(file!.path),
            dospace.Permissions.public);
        var uploaded_file_url = USER_ID! + '/' + result1 + '/' + file_name;
        profiles.add(uploaded_file_url);
      } catch (error) {
      }
    }
    await spaces.close();

  }

  String removeChars(String text, String charsToRemove) {
    final newString = StringBuffer();
    for (final char in text.runes) {
      if (!charsToRemove.contains(String.fromCharCode(char))) {
        newString.write(String.fromCharCode(char));
      }
    }
    return newString.toString();
  }

}
