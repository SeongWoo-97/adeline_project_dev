import 'dart:convert';
import 'package:adeline_app/model/profile/accessory_list/accessory/accessory.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/ability_stone_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/item_slot/accessory/accessory_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/equip_engrave_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/item_slot/armor/equip_armor_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/item_slot/weapon/equip_weapon_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/menu_bar.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:provider/provider.dart';

import '../../../model/profile/character_profile.dart';
import '../../../model/profile/character_profile_provider.dart';

class CharacterSearchResultScreen extends StatefulWidget {
  final nickName;

  const CharacterSearchResultScreen({Key? key, this.nickName}) : super(key: key);

  @override
  State<CharacterSearchResultScreen> createState() => _CharacterSearchResultScreenState();
}

class _CharacterSearchResultScreenState extends State<CharacterSearchResultScreen> {
  final AsyncMemoizer memoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(title: Text('캐릭터 정보')),
        body: FutureBuilder(
          future: fetchCharacterProfile(context),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('에러가 발생하였습니다. 개발자에게 문의 바랍니다.'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileInfoWidget(),
                  Card(
                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MenuBarWidget(),
                        Row(
                          children: [
                            EquipWidget(),
                            AccessoryWidget(),
                          ],
                        ),
                        Row(
                          children: [
                            EquipEngraveWidget(),
                            AbilityStoneWidget(),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  fetchCharacterProfile(BuildContext context) async {
    return this.memoizer.runOnce(() async {
      try {
        http.Response response = await http.get(Uri.parse('http://132.226.22.9:3380/lobox/duggy3'));
        Map<String, dynamic> json = jsonDecode(response.body);
        CharacterProfileProvider characterProfileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
        characterProfileProvider.profile = CharacterProfile.fromJson(json);
        return characterProfileProvider;
      } catch (e) {
        print(e);
      }
    });
  }
}
