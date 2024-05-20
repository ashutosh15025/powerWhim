import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/presentation/bloc/authbloc/auth_bloc.dart';
import 'package:powerwhim/presentation/home.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';

import '../../widget/auth_widget/create_password_widget.dart';
import '../../widget/auth_widget/login_widget.dart';
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

  bool login = false;
  String  errormsg = "some error occured";
  bool errorbool = false;

  bool showErrorWidget = false;


  bool loaderVisibility = false;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            print("run");
            if (state is AuthRegistorSuccessState) {
              authMessage = state.mssg;
              USER_ID = state.user_id.toString();
              print(state.user_id);
              showOTPPanel = true;
            } else if (state is VerifyOTPSuccessState) {
              showOTPPanel = !showOTPPanel;
              showConfirmPasswordPanel = true;
            } else if (state is CreatePasswordSuccessState) {
              onPressVerifyPassword();
            }
            else if(state is LoginSuccessState){
                  navigateToHomePage();
            }
            else if (state is ApiFailedState ){
              errormsg = state.mssg;
              setState(() {
                showErrorWidget = true;
              });
            }
            if(state is LoadingState){
              loaderVisibility = true;
              print("loadingstate");
            }
            else
              {
                loaderVisibility = false;
              }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                  backgroundColor: Colors.black,
                  body: Stack(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height:180,
                            margin: EdgeInsets.fromLTRB(0, 120, 0, 10),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/icon/logo.png'),
                              // Replace with your asset path
                              radius: 90,
                              backgroundColor: Colors.black,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black,
                            ),
                          ),
                          login?LoginWidget(signInLogin: onSignInLogIn):
                          SignInScreen(
                            onSignInLogIN: onSignInLogIn,
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
                    ),
                    Visibility(
                        visible: false,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          color: Color.fromRGBO(1, 1, 1, 0.4),
                          child: Center(child: CircularProgressIndicator(
                            color: Colors.yellow,
                          )),
                        )),
                    Visibility(
                         visible: showErrorWidget,
                        child: CustomErrorWidget(mssg: errormsg,error: true, closeErrorWidget: () {
                          setState(() {
                            showErrorWidget = !showErrorWidget;
                          });
                        },)),
                    Visibility(
                       visible: loaderVisibility,
                        child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Color.fromRGBO(0,0,0,.4),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.yellowAccent,
                        ),
                      ),
                    ))
                  ])),
            );
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
void onSignInLogIn() {
    setState(() {
      login=!login;
    });
  }

  void navigateToHomePage(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Home()));

  }
}
