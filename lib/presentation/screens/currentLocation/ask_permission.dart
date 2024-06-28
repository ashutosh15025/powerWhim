import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:powerwhim/presentation/widget/custom/gradient_button_green_yelllow.dart';

import '../../home.dart';

class AskPermission extends StatelessWidget {
  const AskPermission({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileblocBloc, ProfileblocState>(
      listener: (context,state) {
      },
      child: Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade900
                      ),
                      child: Lottie.asset('animations/location.json'))
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text("Location",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(
                              color: Colors.white
                          )
                      ),),)
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("This app needs access to your Location to find nearby Profiles. Would you like to grant permission",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          textStyle: TextStyle(
                              color: Colors.white
                          )
                      ),),)
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.all(24),
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: InkWell(
                    child: GradientButtonGreenYellow(buttonText: 'Allow',),
                    onTap: (){
                      determinePosition(context);
                    },
                  ),
                )
            ),
          ],
        ),
      ),
    ),
    );
  }


  void determinePosition(BuildContext context) async{
    print("ask");
   bool serviceEnabled;
   LocationPermission permission;
   serviceEnabled = await Geolocator.isLocationServiceEnabled();


   permission = await Geolocator.checkPermission();
   if(permission == LocationPermission.denied){
     permission = await Geolocator.requestPermission();
   }
   if(permission == LocationPermission.denied){
    print("permission denied");
   }

   if(permission == LocationPermission.deniedForever){
     print("permission denied Forever");
   }
   if(permission == LocationPermission.whileInUse||permission == LocationPermission.always) {
     Position position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high
     );
     try {
       List<Placemark> placemarks = await placemarkFromCoordinates(
           position.latitude, position.longitude);

       Placemark place = placemarks[0];
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Home()));

       print(place);
     }
     catch (e) {
       print(e);
     }



   }

  }
}
