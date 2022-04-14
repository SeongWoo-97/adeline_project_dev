import 'dart:math';

import 'package:adeline_project_dev/model/user/content/expedition_content.dart';
import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/content_board_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/expedition_content_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/total_gold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../model/user/character/character_model.dart';
import '../../../model/user/expedition/expedition_model.dart';
import '../../../model/user/expedition/expedition_provider.dart';
import '../../../model/user/user.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> characterList = [];
  List<ExpeditionContent> expeditionList = [];

  @override
  void initState() {
    super.initState();
    characterList = Hive.box<User>('characters').get('user')!.characters;
    expeditionList = Hive.box<Expedition>('expedition').get('expeditionList')!.list;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context);

    expeditionProvider.expedition.list = expeditionList;
    userProvider.charactersProvider.characters = characterList;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('HOME'),
        material: (_, __) => MaterialAppBarData(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: .5,
            titleTextStyle: Theme.of(context).textTheme.headline1,
            toolbarHeight: 45),
        cupertino: (_, __) => CupertinoNavigationBarData(),
        trailingActions: [],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ContentBoardWidget(),
          TotalGoldWidget(),
          ExpeditionContentWidget(),
          CharacterSlotWidget(),
        ],
      ),
    );
  }
}
