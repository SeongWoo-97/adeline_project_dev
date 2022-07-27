import 'package:adeline_app/screen/home_work/init_settings/controller/initSettings_controller.dart';
import 'package:adeline_app/screen/home_work/init_settings/mobile/mobile_initSettings.dart';
import 'package:adeline_app/screen/home_work/init_settings/tablet_desktop/not_mobile_initSettings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitSettingsLayout extends StatefulWidget {
  const InitSettingsLayout({Key? key}) : super(key: key);

  @override
  State<InitSettingsLayout> createState() => _InitSettingsLayoutState();
}

class _InitSettingsLayoutState extends State<InitSettingsLayout> {
  InitSettingsController initController = InitSettingsController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => initController,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Desktop & Tablet
          if (constraints.maxWidth >= 768) {
            return NotMobileInitSettingsScreen();
          }
          // Mobile
          return MobileInitSettingsScreen();
        },
      ),
    );
  }
}
