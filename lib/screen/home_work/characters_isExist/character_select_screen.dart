import 'package:adeline_app/main.dart';
import 'package:adeline_app/screen/home_work/character_slot_layout.dart';
import 'package:adeline_app/screen/home_work/init_settings/initSettings_layout.dart';
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
    bool isCharExist = Hive.box<User>(hiveUserName).isNotEmpty;
    bool isExpeditionExist = Hive.box<Expedition>(hiveExpeditionName).isNotEmpty;

    isCharExist && isExpeditionExist ? isExist = true : isExist = false;
  }

  @override
  Widget build(BuildContext context) {
    return isExist ? CharacterSlotLayout() : InitSettingsLayout();
  }
}
