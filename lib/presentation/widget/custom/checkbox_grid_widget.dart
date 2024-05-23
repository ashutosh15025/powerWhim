import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckboxGridWidget extends StatefulWidget {
  const CheckboxGridWidget({super.key, required this.weekAvailability});

  final Function(List<bool>) weekAvailability;

  @override
  State<CheckboxGridWidget> createState() => _CheckboxGridWidgetState();
}

class _CheckboxGridWidgetState extends State<CheckboxGridWidget> {
  List<bool> isSelected =
      List.generate(16, (_) => true);
  List<bool> weeklyAvailability =
  List.generate(14, (_) => true);// List to hold checkbox states
  bool checkedBox = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
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
                            checkedBox=false;
                            isSelected[index] = !isSelected[index];
                            if (index < 8)
                              weeklyAvailability[index-1] = !isSelected[index];
                            else {
                              weeklyAvailability[index-2] = !isSelected[index];;
                            }
                            widget.weekAvailability(weeklyAvailability);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: isSelected[index]
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
                        if(value==true)
                        isSelected = List<bool>.generate(isSelected.length, (index) => true);
                        checkedBox = value!;
                        widget.weekAvailability(weeklyAvailability);
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
    );
  }
}