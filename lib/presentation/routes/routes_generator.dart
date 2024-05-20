import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:powerwhim/data/model/profilemodel/full_profile.dart';
import 'package:powerwhim/presentation/screens/add_profile_screen.dart';
import 'package:powerwhim/presentation/screens/authScreen/auth_screen.dart';
import 'package:powerwhim/presentation/screens/chat_screen/chat_screen.dart';
import 'package:powerwhim/presentation/screens/chat_screen/personal_chat_screen.dart';
import 'package:powerwhim/presentation/screens/my_profile_widget.dart';
import 'package:powerwhim/presentation/screens/onboard_screen.dart';
import 'package:powerwhim/presentation/screens/view_profile_screen.dart';
import 'package:powerwhim/presentation/widget/message_widget/my_message_widget.dart';

import '../home.dart';
import '../screens/OthersProfileScreen.dart';

class RouteGenerator {
  static Route<dynamic> routeGenerate(RouteSettings settings) {
    // Argument comes to args and you can send it another page with casting

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const OnBoardPage());

      case "/auth":
        return MaterialPageRoute(builder: (_) => const AuthScreen());


      case "/home":
        return MaterialPageRoute(builder: (_) => const Home());
      case "/profile":
        var data = settings.arguments as FullProfileModel;
          return MaterialPageRoute(builder: (_) =>  OtherProfileScreen(fullProfileModel: data,));
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