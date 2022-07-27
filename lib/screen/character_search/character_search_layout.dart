import 'package:adeline_app/screen/character_search/controller/profile_controller.dart';
import 'package:adeline_app/screen/character_search/mobile/mobile_character_profile.dart';
import 'package:adeline_app/screen/character_search/tablet_desktop/not_mobile_character_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterSearchLayout extends StatefulWidget {
  final nickName;

  CharacterSearchLayout({this.nickName});

  @override
  State<CharacterSearchLayout> createState() => _CharacterSearchLayoutState();
}

class _CharacterSearchLayoutState extends State<CharacterSearchLayout> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ProfileController controller = Provider.of<ProfileController>(context, listen: false);
    controller.futureFetch = controller.fetchCharacterProfile(context, widget.nickName);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        // desktop, tablet
        if (constraints.maxWidth >= 800) {
          return NotMobileCharacterProfileScreen();
        } // mobile
        else {
          return MobileCharacterProfileScreen();
        }
      }),
    );
  }
}
