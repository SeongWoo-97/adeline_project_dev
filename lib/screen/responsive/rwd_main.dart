import 'dart:ui';

import 'package:adeline_app/model/dark_mode/responsive/rwd_dark_theme_data.dart';
import 'package:adeline_app/screen/responsive/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RwdMainScreen extends StatefulWidget {
  const RwdMainScreen({Key? key}) : super(key: key);

  @override
  State<RwdMainScreen> createState() => _RwdMainScreenState();
}

class _RwdMainScreenState extends State<RwdMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          theme: rwdDarkThemeData,
          scrollBehavior: MyCustomScrollBehavior(),
          home: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
                return RwdHomeScreen();
              }
              if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
                return RwdHomeScreen();
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
      },
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
