import 'package:adeline_app/screen/home_work/character_setting_screen/mobile/mobile_character_settings.dart';
import 'package:adeline_app/screen/home_work/character_setting_screen/tablet_desktop/not_mobile_character_settings.dart';
import 'package:flutter/material.dart';

class CharacterSettingsLayout extends StatefulWidget {
  final characterIndex;

  CharacterSettingsLayout(this.characterIndex);

  @override
  State<CharacterSettingsLayout> createState() => _CharacterSettingsLayoutState();
}

class _CharacterSettingsLayoutState extends State<CharacterSettingsLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 800) {
        return NotMobileCharacterSettingsScreen(widget.characterIndex);
      } else {
        return MobileCharacterSettingsScreen(widget.characterIndex);
      }
    });
  }
}
