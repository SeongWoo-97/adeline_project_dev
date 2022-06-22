import 'package:adeline_app/model/profile/card/card.dart';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardSetEffectWidget extends StatelessWidget {
  const CardSetEffectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    CardModel? card = profile.card;
    if(card?.cardEffectTitle?.length != 0) {
      return ExpansionTile(
        title: Text('장착 중인 카드 효과',style: Theme.of(context).textTheme.bodyText1,),
        subtitle: Text('${card?.cardEffectTitle?.last}',style: Theme.of(context).textTheme.caption?.copyWith(color: Color(0xFF63e925))),
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 4 / 1.4, //item 의 가로 1, 세로 2 의 비율
              mainAxisSpacing: 0, //수평 Padding
              crossAxisSpacing: 0, //수직 Padding
            ),
            shrinkWrap: true,
            itemCount: card?.cardEffectTitle?.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${card?.cardEffectTitle![index]}',style: Theme.of(context).textTheme.caption?.copyWith(color: Color(0xFF63e925)),),
                    Text('${card?.cardEffectDes![index]}',style: Theme.of(context).textTheme.caption,),
                  ],
                ),
              );
            },
          )
        ],
      );
    }
    return SizedBox(height: 10,);
  }
}
