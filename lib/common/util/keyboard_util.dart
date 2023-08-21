
import 'package:flutter/services.dart';

void hideKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}