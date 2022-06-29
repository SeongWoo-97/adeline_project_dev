import 'dart:ui';

import 'package:adeline_app/model/dark_mode/responsive/rwd_dark_theme_data.dart';
import 'package:adeline_app/screen/responsive/bottom_navigation/screen/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RwdMainScreen extends StatefulWidget {
  const RwdMainScreen({Key? key}) : super(key: key);

  @override
  State<RwdMainScreen> createState() => _RwdMainScreenState();
}

class _RwdMainScreenState extends State<RwdMainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: rwdDarkThemeData,
      scrollBehavior: MyCustomScrollBehavior(),
      home: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return Scaffold(
                appBar: AppBar(
                    title: Text(
                  '${sizingInformation.deviceScreenType}',
                )),
                body: RwdBottomNavigationScreen());
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
            return Scaffold(
                appBar: AppBar(
                    title: Text(
                      '${sizingInformation.deviceScreenType}',
                    )),
                body: RwdBottomNavigationScreen());
          }

          if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
            return Container(color: Colors.yellow);
          }
          return Container(
            child: Text('오류'),
          );
        },
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
