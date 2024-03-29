import 'package:flutter/material.dart';

ThemeData androidDarkThemeData = ThemeData(
  // primarySwatch: MaterialColor(primary, swatch) : MaterialColor(),
  primaryColor: Colors.grey[900],
  scaffoldBackgroundColor: Color(0xFF212121),
  backgroundColor: Colors.black,
  indicatorColor: Colors.cyanAccent,
  unselectedWidgetColor: Colors.white,
  hintColor: Colors.grey,
  highlightColor: Color(0xff372901),
  hoverColor: Color(0xff3A3A3B),
  focusColor: Colors.white,
  disabledColor: Colors.grey,
  cardColor: Color(0xFF212121),
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: Colors.white70, width: 0.8),
    ),
  ),
  canvasColor: Color(0xFF212121),
  brightness: Brightness.dark,
  // buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: ColorScheme.dark() : ColorScheme.light()),
  appBarTheme: AppBarTheme(
    elevation: 2,
    backgroundColor: Color(0xFF282828),
    iconTheme: IconThemeData(color: Colors.white),
    toolbarHeight: 45,
    titleTextStyle: TextStyle(
      fontFamily: 'NotoSansKR',
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
    ),
    centerTitle: true,
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.white,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSansKR', fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'NotoSansKR'),
    bodyText2: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'NotoSansKR'),
    caption: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'NotoSansKR'),
  ),
  listTileTheme: ListTileThemeData(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.grey[900],
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.white,
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
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    contentPadding: const EdgeInsets.all(0),
  ),
);
