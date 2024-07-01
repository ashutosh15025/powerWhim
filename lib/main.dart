import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/domain/service/database/database_service.dart';
import 'package:powerwhim/presentation/bloc/authbloc/auth_bloc.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';
import 'package:powerwhim/presentation/routes/routes_generator.dart';


import 'injection_dependencies.dart';


void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  injectionDependencies();
  final DatabaseService databaseService = DatabaseService.instance;
  Map<Object?, Object?>? details = await databaseService.getDetail();

  if (details != null && details.isNotEmpty) {
    USER_ID = details['user_id'] as String?;
    STATUS = details['status'] as String?;

    // Use the userId and status as needed
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    var TABTOOPEN = '/auth';
    if(USER_ID != null && STATUS!=null){
      print(USER_ID);
      print(STATUS);
      TABTOOPEN = '/home';}
    else if(USER_ID!=null){
      TABTOOPEN = '/addProfile';
    }
    print(TABTOOPEN);
    return MultiBlocProvider (
        providers: [
          BlocProvider<ProfileblocBloc>(create: (context) => ProfileblocBloc()),
          BlocProvider<ChatBloc>(create: (context) => ChatBloc()),
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        ],
      child: MaterialApp(
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: Colors.transparent,
          ),
        ),
      initialRoute: USER_ID==null?'/':TABTOOPEN,
    onGenerateRoute: RouteGenerator.routeGenerate,
    ));
  }
}

