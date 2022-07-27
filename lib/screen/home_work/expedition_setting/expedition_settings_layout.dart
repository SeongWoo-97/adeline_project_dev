import 'package:adeline_app/screen/home_work/expedition_setting/mobile/expedition_setting_screen.dart';
import 'package:adeline_app/screen/home_work/expedition_setting/tablet_desktop/not_mobile_expedition_settings.dart';
import 'package:flutter/material.dart';

class ExpeditionSettingsLayout extends StatefulWidget {
  const ExpeditionSettingsLayout({Key? key}) : super(key: key);

  @override
  State<ExpeditionSettingsLayout> createState() => _ExpeditionSettingsLayoutState();
}

class _ExpeditionSettingsLayoutState extends State<ExpeditionSettingsLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 800) {
        return NotMobileExpeditionSettingsScreen();
      } else {
        return MobileExpeditionSettingScreen();
      }
    });
  }
}
