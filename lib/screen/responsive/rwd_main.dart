import 'package:adeline_app/model/dark_mode/responsive/rwd_dark_theme_data.dart';
import 'package:adeline_app/screen/responsive/bottom_navigation/screen/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RwdMainScreen extends StatefulWidget {
  const RwdMainScreen({Key? key}) : super(key: key);

  @override
  State<RwdMainScreen> createState() => _RwdMainScreenState();
}

class _RwdMainScreenState extends State<RwdMainScreen> {
  @override
  Widget build(BuildContext context) {
    print('리비');
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          theme: rwdDarkThemeData,
          home: RwdBottomNavigationScreen(),
        );
      },
    );
  }
}
