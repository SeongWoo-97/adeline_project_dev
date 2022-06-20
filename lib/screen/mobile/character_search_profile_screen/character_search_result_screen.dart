import 'dart:convert';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/menu_bar_controller.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/avatar_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/collection_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/equip_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/menu_bar.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/profile_info.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/skill/skill_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:provider/provider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';

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
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    MenuBarController menuBarController = Provider.of<MenuBarController>(context, listen: false);
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
              return ScrollConfiguration(
                behavior: CustomScroll(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileInfoWidget(),
                      Card(
                        child: Column(
                          children: [
                            MenuBarWidget(),
                            ExpandablePageView(
                              controller: menuBarController.pageController,
                              onPageChanged: (value) => menuBarController.menuOnChanged(value),
                              children: [
                                EquipScreen(),
                                SkillScreen(),
                                CollectionScreen(),
                                AvatarScreen(),
                              ],
                            ),
                          ],
                        )
                      )
                    ],
                  )
                ),
              );
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ));
  }
  fetchCharacterProfile(BuildContext context) async {
    return this.memoizer.runOnce(() async {
      try {
        http.Response response = await http.get(Uri.parse('http://132.226.22.9:3380/lobox/성우웅'));
        Map<String, dynamic> json = jsonDecode(response.body);
        CharacterProfileProvider characterProfileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
        characterProfileProvider.profile = CharacterProfile.fromJson(json);
        return characterProfileProvider;
      } catch (e) {
        print('에러 : $e');
      }
    });
  }
}
class CustomScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}