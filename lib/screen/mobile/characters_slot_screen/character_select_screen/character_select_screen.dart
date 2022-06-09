import 'package:adeline_app/screen/mobile/characters_slot_screen/characters_slot_screen.dart';
import 'package:adeline_app/screen/mobile/characters_slot_screen/init_screen/initSettings_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../model/user/expedition/expedition_model.dart';
import '../../../../model/user/user.dart';

class CharacterSelectScreen extends StatefulWidget {
  const CharacterSelectScreen({Key? key}) : super(key: key);

  @override
  State<CharacterSelectScreen> createState() => _CharacterSelectScreenState();
}

class _CharacterSelectScreenState extends State<CharacterSelectScreen> {
  bool isExist = false;

  @override
  void initState() {
    super.initState();
    bool isCharExist = Hive.box<User>('characters').isNotEmpty;
    bool isExpeditionExist = Hive.box<Expedition>('expedition').isNotEmpty;

    isCharExist && isExpeditionExist ? isExist = true : isExist = false;
  }

  @override
  Widget build(BuildContext context) {
    return isExist ? CharactersSlotScreen() : InitSettingsScreen();
  }
}
