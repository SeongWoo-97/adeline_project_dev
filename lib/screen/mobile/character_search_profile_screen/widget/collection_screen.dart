import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/menu_bar_controller.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/collection/collection_mococo_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/collection/collection_normal_screen.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';

import 'collection/collection_menu_bar_widget.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionMenuBarController menuBarController = Provider.of<CollectionMenuBarController>(context, listen: false);
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    return Column(
      children: [
        CollectionMenuBarWidget(),
        ExpandablePageView(
          controller: menuBarController.pageController,
          onPageChanged: (value) => menuBarController.menuOnChanged(value),
          children: [
            CollectionNormalScreen(collectionImageIndex: 1,collectionName: '섬의 마음',form: profile.collectivePoint?.mindIsland),
            CollectionNormalScreen(collectionImageIndex: 2,collectionName: '오르페우스의 별',form: profile.collectivePoint?.orpheusStar),
            CollectionNormalScreen(collectionImageIndex: 3,collectionName: '거인의 심장',form: profile.collectivePoint?.heartGiant),
            CollectionNormalScreen(collectionImageIndex: 4,collectionName: '위대한 미술품',form: profile.collectivePoint?.greatWorksArt),
            CollectionMococoScreen(collectionImageIndex: 5,collectionName: '모코코 씨앗',form: profile.collectivePoint?.seedMococo),
            CollectionNormalScreen(collectionImageIndex: 6,collectionName: '항해 모험물',form: profile.collectivePoint?.voyageItem),
            CollectionNormalScreen(collectionImageIndex: 7,collectionName: '이그네아의 징표',form: profile.collectivePoint?.ignaeaToken),
            CollectionNormalScreen(collectionImageIndex: 8,collectionName: '세계수의 잎',form: profile.collectivePoint?.leafWorld),
          ],
        ),
      ],
    );
  }
}
