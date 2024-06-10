import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/service_api_constant.dart';
import '../custom/custom_slider_thumb.dart';

class DistanceSlider extends StatefulWidget {
  const DistanceSlider({super.key, required this.setDistance, this.distance});
  final Function(int) setDistance;
  final int ? distance ;

  @override
  State<DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  int distance = 10;

  @override
  void initState() {
    if(widget.distance!=null)
    distance = widget.distance!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Preferred meeting distance",
              style: GoogleFonts.baloo2(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white),
              )),
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
              value: distance.toDouble(),
              onChanged: (value) {
                setState(() {
                  distance = value.toInt();
                   widget.setDistance(distance);
                });
              },
              activeColor: green,
              inactiveColor: Colors.yellow.shade500,
              thumbColor: Color.fromRGBO(0, 156, 74, 1),
              label: "${distance.toInt()} Km",
              min: 5,
              max: 100,
            ),
          ),
        ),
      ],
    );
  }
}
