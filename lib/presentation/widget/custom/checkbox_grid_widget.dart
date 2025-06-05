import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckboxGridWidget extends StatefulWidget {
  const CheckboxGridWidget({super.key, required this.weekAvailability, this.previousweekAvailability});

  final Function(List<bool>) weekAvailability;
  final List<String> ?previousweekAvailability;

  @override
  State<CheckboxGridWidget> createState() => _CheckboxGridWidgetState();
}

class _CheckboxGridWidgetState extends State<CheckboxGridWidget> {
  List<bool> isSelected = List.generate(16, (_) => true);
  @override
  void initState() {
    if( widget.previousweekAvailability!=null){
      for(var i=0;i<widget.previousweekAvailability!.length;i++){
        if (widget.previousweekAvailability![i] == "1"){
          weeklyAvailability[i] = true;}
        else
          weeklyAvailability[i] = false;
      }
    }
    super.initState();
  }

  List<String> weekDays = ["","S", "M", "T", "W", "T", "F", "S"];

  List<bool> weeklyAvailability =
      List.generate(14, (_) => true); // List to hold checkbox states
  bool checkedBox = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width - 140,
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                      ),
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text(weekDays[index],
                          style:GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.white,
                            )
                          ),),
                        );
                      }))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 140,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                  ),
                  itemCount: 16,
                  itemBuilder: (BuildContext context, int index) {
                    if (index % 8 != 0) {
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                print(index);
                                checkedBox = false;
                                isSelected[index] = !isSelected[index];
                                if (index < 8)
                                  weeklyAvailability[index - 1] =
                                      !weeklyAvailability[index - 1] ;
                                else {
                                  weeklyAvailability[index - 2] =
                                      !weeklyAvailability[index - 2];
                                  ;
                                }
                                widget.weekAvailability(weeklyAvailability);
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child:weeklyAvailability[index - ((index/8)+1).toInt()]
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.green,
                                    ),
                            ),
                          ));
                    } else {
                      var time = "Am";
                      if (index != 0) time = "Pm";

                      return Center(
                        child: Text(
                          time,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Column(
                  children: [
                    Checkbox(
                        value: checkedBox,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            if (value == true)
                              isSelected = List<bool>.generate(
                                  isSelected.length, (index) => true);
                            weeklyAvailability=List<bool>.generate(
                                weeklyAvailability.length, (index) => true);
                            widget.weekAvailability(weeklyAvailability);
                            checkedBox = value!;
                          });
                        }),
                    Text(
                      "No Limit",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
