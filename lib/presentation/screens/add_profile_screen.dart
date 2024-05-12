
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:powerwhim/presentation/screens/view_profile_screen.dart';

import '../../constant/service_api_constant.dart';
import '../widget/checkbox_grid_widget.dart';
import '../widget/custom/custom_slider_thumb.dart';
import '../widget/custom_drop_down.dart';
import '../widget/custom_input_Field.dart';
import '../widget/date_picker_widget.dart';
import '../widget/gradient_button_green_yelllow.dart';
import '../widget/message_widget/custom_range_thumb.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  double start =18;
  double end = 28;
  int distance = 10;
  bool noRelaventSport= false;
  String dropdownvalue = "1";
  late IndicatorRangeSliderThumbShape<int> indicatorRangeSliderThumbShape =
  IndicatorRangeSliderThumbShape(18, 60);
  List<String> myList = ["Option 1", "Option 2", "Option 3"];

  String selectedValue = "Option 1"; // Initial selection
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    if(index == 1){

    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = myList.map((String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    )).toList();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Center(
          child: Text("Add Profile",
          style: GoogleFonts.baloo2(
            textStyle:TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700
          ),)),
        ),
        backgroundColor: Colors.black,
      ),
      body:Container(

        height: MediaQuery.of(context).size.height - 0,
        child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             CustomInputFiels(title: "Name",placeholder: "Enter Your Name",description: "If you dont want people guessing" ,),
             DatePicker(),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("Set a age range",
                style: GoogleFonts.baloo2(
                  textStyle:TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white
                ),)),
             ),
             Padding(
               padding: const EdgeInsets.fromLTRB(0, 30, 0, 16),
               child: SliderTheme(
                 data: SliderThemeData(
                   thumbColor: Colors.blue,
                   overlayColor: Colors.blue.withOpacity(0.2),
                   rangeThumbShape: indicatorRangeSliderThumbShape,
                   overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                 ),
                 child: RangeSlider(values: RangeValues(start,end), onChanged: (value){

                   setState(() {
                     if(value.end - value.start>10){
                     start = value.start;
                     indicatorRangeSliderThumbShape.start =
                         value.start.toInt();
                     indicatorRangeSliderThumbShape.end = value.end.toInt();
                     end = value.end;}
                   });
                 },

                   activeColor:  green,
                   inactiveColor: Colors.yellow.shade600,
                   labels: RangeLabels(
                     start.round().toString(),
                     end.round().toString(),
                   ),
                 min:18,
                   max:100,

                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("Preferred meeting distance",
                 style: GoogleFonts.baloo2(
                   textStyle:TextStyle(
                   fontWeight: FontWeight.w500,
                   fontSize: 16,
                   color: Colors.white
               ),)),
             ),
             SliderTheme(
               data: SliderTheme.of(context).copyWith(
                   thumbShape: CircleSliderThumbShape(
                     radius: 12.0,
                     tooltipText: '"_value"',
                   )),
               child: Padding(
                 padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                 child: Slider(
                   value: distance.toDouble(), onChanged: (value){
                   setState(() {
                     distance = value.toInt();
                   });


                 },
                   activeColor:  green,
                   inactiveColor: Colors.yellow.shade500,
                   thumbColor: Color.fromRGBO(0, 156, 74, 1),
                   label: "${distance.toInt()} Km",
                   min: 5,
                   max: 100, ),
               ),
             ),
             const CustomDropDown(dropDownHeading: "Sports You Participated in",),
             const CustomDropDown(dropDownHeading: "Your Hobbies"),
             Checkbox(value: noRelaventSport, activeColor: green,
                 onChanged: (value){
                   setState(() {
                     noRelaventSport =  value!;
                   });
                 }),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("Estimated weekly availability",
                   style: GoogleFonts.baloo2(
                     textStyle:TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 16,
                         color: Colors.white
                     ),)),
             ),

             SizedBox(
                 child: Container(
                   padding: const EdgeInsets.all(8.0),
                   margin: const EdgeInsets.all(8.0),
                   child: CheckboxGrid(),
                 )
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("Your Goal/Ambition",
                   style: GoogleFonts.baloo2(
                     textStyle:TextStyle(
                         fontWeight: FontWeight.w400,
                         fontSize: 16,
                         color: Colors.white
                     ),)),
             ),
             Container(
               margin: EdgeInsets.all(8),
               width: double.infinity, // <-- TextField width
               height: 120, // <-- TextField height
               padding: EdgeInsets.all(4),
               child: TextField(
                 cursorColor: Colors.yellow.shade600,
                 maxLines: null,
                 expands: true,
                 style: GoogleFonts.baloo2(
                   textStyle:TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 12,
                       color: Colors.white
                   ),),
                 keyboardType: TextInputType.multiline,
                 decoration: InputDecoration.collapsed(filled: true, hintText: 'Enter a message',
                   fillColor: Color.fromRGBO(0, 0, 0, 0),
                   hintStyle:GoogleFonts.baloo2(
                     textStyle:TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 12,
                         color: Colors.white
                     ),),
                 ),
               ),

               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(8),
                 border: Border.all(width: 1,color: Colors.yellow.shade600),
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("Your Accomplishments",
                 style: GoogleFonts.baloo2(
                   textStyle:TextStyle(
                       fontWeight: FontWeight.w400,
                       fontSize: 16,
                       color: Colors.white
                   ),)),
             ),
             Container(
               margin: EdgeInsets.all(8),
               width: double.infinity, // <-- TextField width
               height: 120, // <-- TextField height
               padding: EdgeInsets.all(4),
               child: TextField(
                 cursorColor: Colors.yellow.shade600,
                 maxLines: null,
                 expands: true,
                 style: GoogleFonts.baloo2(
                   textStyle:TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 12,
                       color: Colors.white
                   ),),
                 keyboardType: TextInputType.multiline,
                 decoration: InputDecoration.collapsed(filled: true, hintText: 'Enter a message',
                   fillColor: Color.fromRGBO(0, 0, 0, 0),
                   hintStyle:GoogleFonts.baloo2(
                     textStyle:TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 12,
                     color: Colors.white
                 ),),
                 ),
               ),

               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   border: Border.all(width: 1,color: Colors.yellow.shade600),
               ),
             ),
             Center(
               child: InkWell(
                 onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ViewProfilesScreen()));
                   print("ashes");
                 },
                 child: Center(child: Container(
                     margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                     width: MediaQuery.of(context).size.width-100,
                     child: GradientButtonGreenYellow(buttonText: "Submit"))),
               ),
             )

            ,
             Padding(padding: EdgeInsets.all(60)),
           ],
         ),
        ),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
      ),
        bottomNavigationBar: Container(
          color: Color.fromRGBO(0, 0, 0, 0),
          child: MoltenBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onTabChange: (clickedIndex) {
              setState(() {
                _selectedIndex = clickedIndex;
                _onItemTapped(_selectedIndex);
              });
            },
            barColor: Colors.black12,
              domeCircleColor:Colors.blueGrey,
              tabs: [
              MoltenTab(
                icon: Icon(Icons.home,
                color:  _selectedIndex==0?Colors.white:Colors.blueGrey,),
              ),
                MoltenTab(
                  icon: Icon(Icons.groups,
                    color:  _selectedIndex==1?Colors.white:Colors.blueGrey,),
                ),
                MoltenTab(
                  icon: Icon(Icons.chat,
                    color:  _selectedIndex==2?Colors.white:Colors.blueGrey,),
                ),
                MoltenTab(
                  icon: Icon(Icons.person,
                    color:  _selectedIndex==3?Colors.white:Colors.blueGrey,),
                ),
                MoltenTab(
                  icon: Icon(Icons.headphones_rounded,
                    color:  _selectedIndex==4?Colors.white:Colors.blueGrey,),
                ),
            ],
          ),
        ),
    );

  }


}
