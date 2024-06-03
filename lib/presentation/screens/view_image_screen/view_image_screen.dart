import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewImageScreen extends StatelessWidget {
  const ViewImageScreen({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(0),
        color: Colors.black,
        child: Center(

          child: Image.network("https://whim.ams3.digitaloceanspaces.com/"+image),
        ),
      ),
    );
  }
}
