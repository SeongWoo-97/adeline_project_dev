import 'package:adeline_app/model/profile/card/card.dart';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/screen/character_search/controller/slot_Color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    CardModel card = profile.card!;
    List<Widget> list = [];
    for(int index = 0; index < card.cardName!.length ; index++){
      Color nameColor = slotColor.cardNameColor(int.parse(card.cardGrade![index]));
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
      list.add(Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Image.network(
                  '${card.cardImgUrl![index]}',
                  width: 125,
                  height: 200,
                ),
              ),
              Image.asset(
                'assets/card/grade_${int.parse(card.cardGrade![index])}.png',
                width: 134,
                height: 200,
              ),
              Positioned(
                left: 6,
                bottom: 10,
                child: Row(
                  children: gemActive,
                ),
              )
            ],
          ),
          Text('${card.cardName![index]}', style: Theme.of(context).textTheme.caption?.copyWith(color: nameColor))
        ],
      ));
    }
    if (card.cardName?.length != 0) {
      return Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: list,
      );
    }
    return Container();
  }
}
