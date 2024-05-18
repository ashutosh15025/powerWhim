import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/service_api_constant.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.setDOB});
  final Function(String) setDOB;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _dateController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1)
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1)
              ),
              hintText: "Date of Birth",
              hintStyle: GoogleFonts.baloo2(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
            ),
            readOnly: true,
            onTap: () {
              _selectDate();
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,8, 0, 0),
            child: Text("widget.description",
              style: GoogleFonts.baloo2(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.white
                ),
              ),),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime ?_pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: green, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            datePickerTheme: const DatePickerThemeData(
              headerBackgroundColor: green,
              headerForegroundColor: Colors.white,
              backgroundColor: Color(0xFFE6F3FD),
            ),
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
          ),
          child: child!,
        );
      },
    );
    if (_pickDate != null) {
      setState(() {
        _dateController.text = _pickDate.toString().split(" ")[0];
        widget.setDOB(_dateController.text);
      });
    }
  }
}
