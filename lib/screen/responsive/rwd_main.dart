import 'package:adeline_app/model/dark_mode/responsive/rwd_dark_theme_data.dart';
import 'package:adeline_app/screen/responsive/bottom_navigation/screen/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RwdMainScreen extends StatefulWidget {
  const RwdMainScreen({Key? key}) : super(key: key);

  @override
  State<RwdMainScreen> createState() => _RwdMainScreenState();
}

class _RwdMainScreenState extends State<RwdMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360,690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: rwdDarkThemeData,
          home: child,
          debugShowCheckedModeBanner: false,
        );
      },
      child: RwdBottomNavigationScreen(),
    );
  }
}