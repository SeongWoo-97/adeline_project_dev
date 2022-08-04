import 'package:adeline_app/screen/home_work/character_reorder_screen/mobile/mobile_character_reorder_screen.dart';
import 'package:adeline_app/screen/home_work/character_reorder_screen/tablet_desktop/not_mobile_character_reorder_screen.dart';
import 'package:flutter/material.dart';

class CharacterReOrderLayout extends StatefulWidget {
  const CharacterReOrderLayout({Key? key}) : super(key: key);

  @override
  State<CharacterReOrderLayout> createState() => _CharacterReOrderLayoutState();
}

class _CharacterReOrderLayoutState extends State<CharacterReOrderLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 800) {
        return NotMobileCharacterReOrderScreen();
      } else {
        return MobileCharacterReOrderScreen();
      }
    });
  }
}
