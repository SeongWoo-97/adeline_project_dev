import 'package:adeline_app/model/profile/card/card.dart';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    CardModel? card = profile.card;
    if (card?.cardName?.length != 0) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1.8, //item 의 가로 1, 세로 2 의 비율
          mainAxisSpacing: 0, //수평 Padding
          crossAxisSpacing: 10, //수직 Padding
        ),
        itemCount: card?.cardName?.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.network('${card?.cardImgUrl![index]}'),
              Text('${card?.cardName![index]}',style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.amber),)
            ],
          );
        },
      );
    }
    return Container();
  }
}
