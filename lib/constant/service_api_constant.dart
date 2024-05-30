
import 'dart:ui';
import 'package:socket_io_client/socket_io_client.dart' as IO;
const BASE_URL = "http://192.168.29.226:3000/";

const Color green = Color.fromRGBO(0, 156, 74, 1);



enum STATUS {success,failed}

extension STATUSVALUE on STATUS {
  static const values = {
    STATUS.success: 'success',
    STATUS.failed: 'failed',
  };
}
const ERROR ="some error Accured";

String ? USER_ID = "28d53919-b837-4eee-b85b-f7389784ec6f";

IO.Socket ? SOCKET ;

