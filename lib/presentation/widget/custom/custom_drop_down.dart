import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/bloc/authbloc/auth_bloc.dart';
import 'package:powerwhim/presentation/widget/custom/selected_drop_item_widget.dart';

import '../../../constant/service_api_constant.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      {super.key, required this.dropDownHeading, required this.selectedItemFun, this.name,});

  final String dropDownHeading;
  final String ? name;
  final void Function(List<String>) selectedItemFun;


  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  List<String> myList = [];
  List<String> selectedItem = [];
  bool notRelavent = false;

  String ? selectedValue; // Initial selection
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.name=="hobbies") myList = BlocProvider.of<AuthBloc>(context).hobbiesList;
    else if(widget.name=="sports") myList = BlocProvider.of<AuthBloc>(context).sportsList;

    List<DropdownMenuItem<String>> dropdownItems = myList.map((String value) =>
        DropdownMenuItem<String>(
          value: value,
          child: Container(
            child: Text(value,
              style: TextStyle(
                  color: Colors.black
              ),),
          ),
        )).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${widget.dropDownHeading}",
              style: GoogleFonts.baloo2(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white
                ),)),
        ),
        InkWell(
          onTap: (){
            print("container");
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.yellow.shade500),
                borderRadius: BorderRadius.circular(8)
            ),
            child: InkWell(
              onTap: (){
              },
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    hint: Text("${widget.dropDownHeading}",
                        style: GoogleFonts.baloo2(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white
                          ),)),
                    style: TextStyle(color: Colors.white),
                    selectedItemBuilder: (BuildContext context) {
                      return myList.map<Widget>((String item) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Text("Please select something",
                              style: GoogleFonts.baloo2(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white
                                ),)),
                        );
                      }).toList();
                    },
                    iconEnabledColor: Colors.yellow.shade500,
                    value: selectedValue,
                    items: dropdownItems,
                    onChanged: (String? newValue) {
                      if (selectedItem.indexOf(newValue!) == -1)
                        selectedItem.add(newValue!);
                      setState(() {
                        print(newValue.toString());
                        widget.selectedItemFun(selectedItem);
                        selectedValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Wrap(
            spacing: 8.0, // Adjust spacing between chips
            runSpacing: 4.0, // Adjust spacing between lines of chips
            children: List<Widget>.generate(
              selectedItem.length,
                  (int index) {
                return Chip(
                  side: BorderSide(color: Color.fromRGBO(0, 156, 74, 1)),
                  elevation: 0,
                  shadowColor: Colors.white,
                  deleteIconColor: Colors.white,
                  backgroundColor: Color.fromRGBO(0, 156, 74, 1),
                  shape: StadiumBorder(
                  ),
                  label: Text(selectedItem[index],
                    style: GoogleFonts.baloo2(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )
                    ),),
                  // You can also customize other properties of the Chip widget here
                  onDeleted: () {
                    setState(() {
                      selectedItem.removeAt(index);
                      widget.selectedItemFun(selectedItem);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(value: notRelavent, onChanged: (updateValue) {
              setState(() {
                notRelavent = updateValue!;
                selectedItem = [];
                widget.selectedItemFun(selectedItem);
              },
              );
            },
              checkColor: Colors.white,
              activeColor: Colors.green,),
            Text("Not Relavant to me",
              style: GoogleFonts.baloo2(
                  textStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: notRelavent ? Colors.white : Colors.grey
                  )
              ),)
          ],
        )
      ],
    );
  }
}
