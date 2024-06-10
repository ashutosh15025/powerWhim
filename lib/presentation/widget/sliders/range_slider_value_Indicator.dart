import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/service_api_constant.dart';
import '../message_widget/custom_range_thumb.dart';

class SetAgeRangeSlider extends StatefulWidget {
  const SetAgeRangeSlider({super.key, required this.setageRange, this.startAge, this.endAge});
  final Function(String,String) setageRange;
  final String ? startAge;
  final String ? endAge;

  @override
  State<SetAgeRangeSlider> createState() => _SetAgeRangeSliderState();
}

class _SetAgeRangeSliderState extends State<SetAgeRangeSlider> {
  late IndicatorRangeSliderThumbShape<int> indicatorRangeSliderThumbShape =
  IndicatorRangeSliderThumbShape(int.parse(widget.startAge!), int.parse(widget.endAge!));

  @override
  void initState() {
     start =double.parse(widget.startAge!);
     end =  double.parse(widget.endAge!);
    super.initState();
  }

  double start =18;
  double end = 28;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  end = value.end;
                  widget.setageRange(start.toString(),end.toString());
                }
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
        )
      ],
    );
  }
}
