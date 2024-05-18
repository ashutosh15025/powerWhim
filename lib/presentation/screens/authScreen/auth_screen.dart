import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/presentation/bloc/authbloc/auth_bloc.dart';

import '../../widget/auth_widget/create_password_widget.dart';
import '../../widget/auth_widget/signin_widget.dart';
import '../../widget/auth_widget/verify_otp_widget.dart';
import '../add_profile_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthScreen> {
  bool passwordVisibility = false;
  bool showOTPPanel = false;
  bool showConfirmPasswordPanel = false;

  String? authMessage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRegistorSuccessState) {
              authMessage = state.mssg;
              USER_ID = state.user_id.toString();
              print(state.user_id);
              showOTPPanel = true;
            } else if (state is AuthRegistorFailedState) {
              print(state.mssg);
            } else if (state is VerifyOTPSuccessState) {
              showOTPPanel = !showOTPPanel;
              showConfirmPasswordPanel = true;
            } else if (state is CreatePasswordSuccessState) {
              onPressVerifyPassword();
            }
          },
          builder: (context, state) {
            return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          margin: EdgeInsets.fromLTRB(0, 100, 0, 100),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/icon/logo.png'),
                            // Replace with your asset path
                            radius: 75,
                            backgroundColor: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black,
                          ),
                        ),
                        SignInScreen(
                          onPressNextButton: onPressCrossOTP,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: showConfirmPasswordPanel,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: CreatePasswordWidget(
                        onPressCrossButton: onPressCrossPassword,
                        onPressVerifyButton: onPressVerifyPassword,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showOTPPanel,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: VerifyOptWidget(
                        onPressCrossButton: onPressCrossOTP,
                        onPressVerifyButton: onPressVerifyOTP,
                      ),
                    ),
                  )
                ]));
          },
        ));
  }

  void onPressCrossOTP() {
    setState(() {
      showOTPPanel = !showOTPPanel;
    });
  }

  void onPressVerifyOTP() {
    setState(() {
      print("otppannel");
      showConfirmPasswordPanel = !showConfirmPasswordPanel;
      showOTPPanel = !showOTPPanel;
    });
  }

  void onPressVerifyPassword() {
    setState(() {
      print("showConfirmPasswordPanel");
      showConfirmPasswordPanel = !showConfirmPasswordPanel;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AddProfileScreen()));
    });
  }

  void onPressCrossPassword() {
    setState(() {
      showConfirmPasswordPanel = !showConfirmPasswordPanel;
    });
  }
}
