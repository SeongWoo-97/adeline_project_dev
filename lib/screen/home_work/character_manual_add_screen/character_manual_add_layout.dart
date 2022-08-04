import 'package:adeline_app/screen/home_work/character_manual_add_screen/mobile/character_manual_add_screen.dart';
import 'package:adeline_app/screen/home_work/character_manual_add_screen/tablet_desktop/not_mobile_character_manual_add.dart';
import 'package:flutter/material.dart';

class CharacterManualAddLayout extends StatefulWidget {
  const CharacterManualAddLayout({Key? key}) : super(key: key);

  @override
  State<CharacterManualAddLayout> createState() => _CharacterManualAddLayoutState();
}

class _CharacterManualAddLayoutState extends State<CharacterManualAddLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 800) {
        return NotMobileCharacterManualAddScreen();
      } else {
        return MobileCharacterManualAddScreen();
      }
    });
  }
}
