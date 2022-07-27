import 'package:adeline_app/screen/character_search/widget/avatar/avatar_over_widget.dart';
import 'package:adeline_app/screen/character_search/widget/avatar/avatar_widget.dart';
import 'package:flutter/material.dart';

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
