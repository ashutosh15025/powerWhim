import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckboxGrid extends StatefulWidget {
  @override
  _CheckboxGridState createState() => _CheckboxGridState();
}

class _CheckboxGridState extends State<CheckboxGrid> {
  List<bool> isSelected = List.generate(16, (_) => false); // List to hold checkbox states
  bool checkedBox = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width-120,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemCount: 16,
              itemBuilder: (BuildContext context, int index) {
                if(index%8!=0){
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: Colors.grey,width: 1)
                  ),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        isSelected[index] = !isSelected[index];
                      });
                    },
                    child: Visibility(
                      visible: isSelected[index],
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Icon(Icons.check,
                        color: Colors.green,),
                      ),
                    ),
                  ),
                  );
                  }
                else{
                  var time = "Am";
                  if(index!=0)
                    time = "Pm";

                  return Center(
                    child:  Text(time,
                    style: TextStyle(
                      color: Colors.white
                    ),),
                  );
                }
                },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Column(
              children: [
                Checkbox(value: checkedBox, activeColor: Colors.green,
                    onChanged: (value){
                      setState(() {
                        checkedBox =  value!;
                      });
                    }),
                Text("No Limit",
                  style: TextStyle(
                      color: Colors.white
                  ),)
              ],
            ),
          )

        ],
      ),
    );
  }
}