import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/widget/not_mobile_character_slot_list.dart';
import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/widget/not_mobile_content_board.dart';
import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/widget/not_mobile_expedition_content.dart';
import 'package:adeline_app/screen/home_work/characters_slot/widget/total_gold.dart';
import 'package:flutter/material.dart';

class NotMobileCharacterSlotScreen extends StatelessWidget {
  const NotMobileCharacterSlotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('숙제 관리 ${MediaQuery.of(context).size.width},${MediaQuery.of(context).size.height}'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NotMobileContentBoardWidget(),
          Padding(padding: const EdgeInsets.only(left: 5), child: TotalGoldWidget()),
          NotMobileExpeditionContentWidget(),
          NotMobileCharacterSlotListWidget(),
        ],
      ),
    );
  }
}
