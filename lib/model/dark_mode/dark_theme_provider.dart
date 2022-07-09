import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';


class DarkMode {
  static ValueNotifier<bool> isDarkMode = ValueNotifier(Hive.box('themeData').get('darkMode',defaultValue: false));
  
  static setDarkTheme(bool value) {
    isDarkMode.value = value;
    Hive.box('themeData').put('darkMode', value);
  }
}