import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeColor {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        // primarySwatch: isDarkTheme ? MaterialColor(primary, swatch) : MaterialColor(),
        primaryColor: isDarkTheme ? Colors.grey[900] : Colors.white,
        scaffoldBackgroundColor: isDarkTheme ? Color(0xFF121212) : Colors.white,
        backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
        indicatorColor: isDarkTheme ? Colors.cyanAccent : Colors.indigoAccent,
        unselectedWidgetColor: isDarkTheme ? Colors.white : Colors.grey,
        hintColor: isDarkTheme ? Colors.grey : Colors.grey,
        highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
        hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
        focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
        disabledColor: Colors.grey,
        cardColor: isDarkTheme ? Colors.grey[800] : Colors.white,
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: isDarkTheme ? Colors.white70 : Colors.grey, width: 0.8),
          ),
        ),
        canvasColor: isDarkTheme ? Color(0xFF121212) : Colors.white,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
        appBarTheme: AppBarTheme(
          elevation: 0.5,
          backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.white,
          iconTheme: IconThemeData(color: isDarkTheme ? Colors.white : Colors.black),
          toolbarHeight: 45,
          titleTextStyle: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          centerTitle: true,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            color: isDarkTheme ? Colors.white : Colors.black,
            fontFamily: 'NotoSansKR',
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            color: isDarkTheme ? Colors.white : Colors.black,
            fontFamily: 'NotoSansKR',
          ),
          caption: TextStyle(
            fontSize: 12,
            color: isDarkTheme ? Colors.white : Colors.black,
            fontFamily: 'NotoSansKR',
          ),
        ),
        listTileTheme: ListTileThemeData(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: isDarkTheme ? Colors.grey[900] : Colors.white,
            textStyle: TextStyle(
              fontSize: 14,
              color: isDarkTheme ? Colors.white : Colors.black,
              fontFamily: 'NotoSansKR',
            ),
            elevation: 0,
            side: BorderSide(width: 1, color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.indigoAccent),
        ));
  }
}
