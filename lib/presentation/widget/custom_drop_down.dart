import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/widget/selected_drop_item_widget.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key, required this.dropDownHeading, required this.myList, required this.selectedItemFun});
  final String dropDownHeading;
  final List<String> myList;
  final void Function(List<String>) selectedItemFun;


  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  List<String> selectedItems =[];

  String selectedValue = "Option 1";

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = widget.myList.map((String value) => DropdownMenuItem<String>(
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
                textStyle:TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white
                ),)),
        ),
        Container(
          margin: EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.yellow.shade500),
              borderRadius: BorderRadius.circular(8)
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                style: TextStyle(color: Colors.white),
                selectedItemBuilder: (BuildContext context) {
                return widget.myList.map<Widget>((String item) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0,12,0,0),
                  child: Text("Please select something",
                    style: GoogleFonts.baloo2(
                      textStyle:TextStyle(
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
                  if(newValue!=null)
                    selectedItems.add(newValue!);
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            spacing: 8.0, // Adjust spacing between chips
            runSpacing: 4.0, // Adjust spacing between lines of chips
            children: List<Widget>.generate(
              selectedItems.length,
                  (int index) {
                return Chip(
                  side: BorderSide(color: Color.fromRGBO(0, 156, 74, 1)),
                  elevation: 0,
                  shadowColor: Colors.white,
                  deleteIconColor: Colors.white,
                  backgroundColor: Color.fromRGBO(0, 156, 74, 1),
                  shape: StadiumBorder(
                  ),
                  label: Text(selectedItems[index],
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
                      selectedItems.removeAt(index);
                      widget.selectedItemFun(selectedItems);
                    });
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
