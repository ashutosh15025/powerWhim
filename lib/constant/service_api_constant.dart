
import 'dart:ui';
import 'package:socket_io_client/socket_io_client.dart' as IO;
const BASE_URL = "http://10.0.2.2:3000/";

const Color green = Color.fromRGBO(0, 156, 74, 1);



enum STATUS {success,failed}

extension STATUSVALUE on STATUS {
  static const values = {
    STATUS.success: 'success',
    STATUS.failed: 'failed',
  };
}
const ERROR ="some error Accured";

String ? USER_ID ;

IO.Socket ? SOCKET ;



List<String> CHATENDREASON = ["I don't think we are going to have much in common, but thanks for your message.","Sorry, I am just not feeling up to it today.","Sorry, I am just not feeling up to it today.","Thanks for getting in contact, but I am looking for something else.","I really appreciate your time, but I am currently away."];

