import 'package:adeline_app/model/profile/card/card.dart';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/slot_Color.dart';

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
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Color nameColor = slotColor.cardNameColor(int.parse(card!.cardGrade![index]));
          // 등급 별 assets 정하기
          int cardCount = int.parse(card.cardCount![index]);
          List<Widget> gemActive = [];
          for (int i = 0; i < 5; i++) {
            if (i < cardCount) {
              gemActive.add(Image.asset(
                'assets/card/gem_active.png',
                filterQuality: FilterQuality.none,
              ));
            } else {
              gemActive.add(Image.asset('assets/card/gem_deActive.png'));
            }
          }
          return Column(
            children: [
              Stack(
                children: [
                  Card(
                      margin: const EdgeInsets.only(top: 4, right: 3, left: 3),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Image.network('${card.cardImgUrl![index]}')),
                  Image.asset('assets/card/grade_${int.parse(card.cardGrade![index])}.png'),
                  Positioned(
                    left: 4,
                    bottom: 10,
                    child: Row(
                      children: gemActive,
                    ),
                  )
                ],
              ),
              Text('${card.cardName![index]}', style: Theme.of(context).textTheme.caption?.copyWith(color: nameColor))
            ],
          );
        },
      );
    }
    return Container();
  }
}
