import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:powerwhim/constant/full_profile_privious_screen.dart';
import 'package:powerwhim/presentation/screens/authScreen/auth_screen.dart';
import 'package:powerwhim/presentation/screens/onboard_screen.dart';

import '../home.dart';
import '../screens/OthersProfileScreen.dart';

class RouteGenerator {
  static Route<dynamic> routeGenerate(RouteSettings settings) {

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const OnBoardPage());

      case "/auth":
        return MaterialPageRoute(builder: (_) => const AuthScreen());


      case "/home":
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
      case "/profile":
        var data = settings.arguments as FullProfilePriviousScreen;
          return MaterialPageRoute(builder: (_) =>  OtherProfileScreen(fullProfilePScreenModel: data));
      default:
        return _errorRoute();


    }

  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

}