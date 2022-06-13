import 'package:adeline_app/model/profile/ability_stone/ability_stone.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/slot_Color.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/equip_engrave_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';

class EngraveEffectWidget extends StatelessWidget {
  const EngraveEffectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    int length = profileProvider.profile.abilityEngraveList!.engraveName!.length;
    List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      String path = profileProvider.profile.abilityEngraveList!.engraveName![i].replaceAll(':', '').split('Lv.')[0].trim();
      list.add(Container(
        height: 35,
        margin: EdgeInsets.all(5),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset('assets/engrave/${path}.png'),
            ),
            Text('${profileProvider.profile.abilityEngraveList!.engraveName![i]}')
          ],
        ),
      ));
    }
    return Container(
      child: Column(
        children: list,
      ),
    );
  }
}

class TempEngrave {
  String name = "";
  String des = "";

  TempEngrave(this.name, this.des);
}
