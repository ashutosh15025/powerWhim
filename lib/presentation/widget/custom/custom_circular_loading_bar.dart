import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircularLoadingBar extends StatefulWidget {
  const CustomCircularLoadingBar({super.key});

  @override
  State<CustomCircularLoadingBar> createState() => _CustomCircularLoadingBarState();
}

class _CustomCircularLoadingBarState extends State<CustomCircularLoadingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.yellowAccent,
        ),
      ),
    );
  }
}
