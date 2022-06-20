import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/avatar/avatar_over_widget.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/avatar/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarWidget(),
            AvatarOverWidget(),
          ],
        )
      ],
    );
  }
}
