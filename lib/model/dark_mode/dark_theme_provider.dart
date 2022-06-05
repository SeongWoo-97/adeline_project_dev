import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';


class DarkMode {
  static ValueNotifier<bool> isDarkMode = ValueNotifier(Hive.box('themeData').get('darkMode',defaultValue: false));

  static getDarkTheme() {
    print(isDarkMode.value);
  }
  static setDarkTheme(bool value) {
    isDarkMode.value = value;
    print(isDarkMode);
    Hive.box('themeData').put('darkMode', value);
  }
}