import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/content_board_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/expedition_content_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/total_gold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {


  @override
  Widget build(BuildContext context) {
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
        trailingActions: [
        ],
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
