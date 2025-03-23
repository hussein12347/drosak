import 'package:flutter/cupertino.dart';

void closeKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}