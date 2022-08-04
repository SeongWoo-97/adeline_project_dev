import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/screen/character_search/controller/menu_bar_controller.dart';
import 'package:adeline_app/screen/character_search/controller/profile_controller.dart';
import 'package:adeline_app/screen/character_search/widget/avatar_screen.dart';
import 'package:adeline_app/screen/character_search/widget/collection_screen.dart';
import 'package:adeline_app/screen/character_search/widget/equip_screen.dart';
import 'package:adeline_app/screen/character_search/widget/menu_bar.dart';
import 'package:adeline_app/screen/character_search/widget/profile_info.dart';
import 'package:adeline_app/screen/character_search/widget/skill/skill_screen.dart';
import 'package:adeline_app/screen/custom_scroll.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotMobileCharacterProfileScreen extends StatelessWidget {
  final nickName;

  NotMobileCharacterProfileScreen({this.nickName});
  @override
  Widget build(BuildContext context) {
    MenuBarController menuBarController = Provider.of<MenuBarController>(context, listen: false);
    CharacterProfileProvider characterProfileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('캐릭터 정보')),
      body: FutureBuilder(
        future: Provider.of<ProfileController>(context,listen: false).futureFetch,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: ProfileInfoWidget(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: Card(
                        child: Column(
                          children: [
                            MenuBarWidget(),
                            ExpandablePageView(
                              controller: menuBarController.pageController,
                              onPageChanged: (value) => menuBarController.menuOnChanged(value),
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(child: EquipScreen()),
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                ' 사용 스킬 포인트 ${characterProfileProvider.profile.info
                                                    ?.useSkillPoint} / 보유 스킬 포인트 ${characterProfileProvider.profile.info?.haveSkillPoint}',
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            ),
                                          ),
                                          SkillScreen(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                CollectionScreen(),
                                AvatarScreen(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
