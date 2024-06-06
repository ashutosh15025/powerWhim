import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/color_constant.dart';


import '../../../constant/service_api_constant.dart';

class AddPhotosProfile extends StatefulWidget {
  const AddPhotosProfile({super.key, required this.getProfile});
  final Function(List<File>) getProfile;

  @override
  State<AddPhotosProfile> createState() => _AddPhotosProfileState();
}

class _AddPhotosProfileState extends State<AddPhotosProfile> {

  File? file;
  List<File> imagesCurrent = [];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8, 32, 8, 32),
          child: Row(
            children: [
              Text(
                "Upload Photos",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                )),
              ),
              Spacer(),
              InkWell(
                onTap: (){
                  openImagePicker();
                },
                child: Text(
                  "+Add Photos",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: themeColorLight,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  )),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: GridView.builder(
            itemBuilder: (BuildContext context,int index){
              return Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    child:  Image.file(
                      imagesCurrent[index]!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  InkWell(
                    onTap:(){
                      setState(() {
                        imagesCurrent.removeAt(index);
                        widget.getProfile(imagesCurrent);
                      });
                  },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(Icons.cancel,color:  Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
            itemCount: imagesCurrent.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing:5,
              mainAxisSpacing: 5,
            ),

          ),
        )
      ],
    );
  }


  void openImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        setState(() {
          imagesCurrent.add(file!);
          widget.getProfile(imagesCurrent);
        });
      });
    } else {}
  }
  String removeChars(String text, String charsToRemove) {
    final newString = StringBuffer();
    for (final char in text.runes) {
      if (!charsToRemove.contains(String.fromCharCode(char))) {
        newString.write(String.fromCharCode(char));
      }
    }
    return newString.toString();
  }


}
