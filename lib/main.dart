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
  USER_ID = await databaseService.getDetail()!=null?await databaseService.getDetail():null;
  print(USER_ID);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
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
      initialRoute: USER_ID==null?'/':'/home',
    onGenerateRoute: RouteGenerator.routeGenerate,
    ));
  }
}

