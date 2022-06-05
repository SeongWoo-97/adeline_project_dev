import 'package:flutter/material.dart';

ThemeData androidLightThemeData = ThemeData(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Color(0xffF1F5FB),
  indicatorColor: Colors.indigoAccent,
  unselectedWidgetColor: Colors.grey,
  hintColor: Colors.grey,
  highlightColor: Color(0xffFCE192),
  hoverColor: Color(0xff4285F4),
  focusColor: Color(0xffA8DAB5),
  disabledColor: Colors.grey,
  cardColor: Colors.white,
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: Colors.grey, width: 0.8),
    ),
  ),
  canvasColor: Colors.white,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    elevation: 0.5,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    toolbarHeight: 45,
    titleTextStyle: TextStyle(
      fontFamily: 'NotoSansKR',
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.black,
    ),
    centerTitle: true,
  ),
  textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.black),
  textTheme: TextTheme(
    headline1: TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
    bodyText1: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'NotoSansKR'),
    bodyText2: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'NotoSansKR'),
    caption: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'NotoSansKR'),
  ),
  listTileTheme: ListTileThemeData(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.black,
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
  ),
  iconTheme: IconThemeData(color: Colors.blue),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    contentPadding: const EdgeInsets.all(0),
  ),
);
