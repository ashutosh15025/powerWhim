
import 'dart:ui';

const BASE_URL = "http://192.168.1.8:3000/";

const Color green = Color.fromRGBO(0, 156, 74, 1);



enum STATUS {success,failed}

extension STATUSVALUE on STATUS {
  static const values = {
    STATUS.success: 'success',
    STATUS.failed: 'failed',
  };
}
const ERROR ="some error Accured";

String ? USER_ID;