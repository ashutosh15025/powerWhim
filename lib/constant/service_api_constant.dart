
import 'dart:ui';
import 'package:socket_io_client/socket_io_client.dart' as IO;
const BASE_URL = "https://whim.cozytech.co.in/";

const Color green = Color.fromRGBO(0, 156, 74, 1);




const ERROR ="some error Accured";

String ? USER_ID ;
String ? STATUS ;

IO.Socket ? SOCKET ;



List<String> CHATENDREASON = ["Thanks for getting in contact but I am looking for something different at this time.",
"I appreciate your time, but I am currently away.",
"I’m currently occupied with other tasks and unable to respond fully, maybe another time?",
"I have no availability currently and unable to accommodate new requests. Please feel free to reach out later."];
