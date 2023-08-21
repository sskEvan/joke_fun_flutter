import 'package:logger/logger.dart';

var _logger = Logger();

LogV(String msg) {
  _logger.v(msg);
}

LogD(String msg) {
  _logger.d(msg);
}

LogI(String msg) {
  _logger.i(msg);
}

LogW(String msg) {
  _logger.w(msg);
}

LogE(String msg) {
  _logger.e(msg);
}

LogWTF(String msg) {
  _logger.wtf(msg);
}
