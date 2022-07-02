import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/ability_info.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/ability_stone_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/card/card_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/card/card_set_effect_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/engrave_list.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/gem/gemSlotWidget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/item_slot/accessory/accessory_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/item_slot/armor/equip_armor_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/total_collection_widget.dart';

import 'package:flutter/material.dart';


class EquipScreen extends StatefulWidget {
  const EquipScreen({Key? key}) : super(key: key);

  @override
  State<EquipScreen> createState() => _EquipScreenState();
}

class _EquipScreenState extends State<EquipScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            EquipWidget(),
            AccessoryWidget(),
          ],
        ),
        GemSlotWidget(),
        AbilityStoneWidget(),
        TotalCollectionPerWidget(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AbilityInfoWidget(),
            EngraveEffectWidget(),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardSetEffectWidget(),
            CardWidget(),
          ],
        )
      ],
    );
  }
}
