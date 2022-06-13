import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';

class EquipEngraveWidget extends StatelessWidget {
  const EquipEngraveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    List<Widget> equipEngraves = [];
    if (profile.equipEngrave?.length != 0) {
      List.generate(2, (index) {
        if (profile.equipEngrave![index].name != null) {
          equipEngraves.add(
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                    child: ClipOval(
                      child: Image.network(
                        'https://cdn-lostark.game.onstove.com/' + profile.equipEngrave![index].imgUrl.toString(),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text('${profile.equipEngrave![index].name} ', style: Theme.of(context).textTheme.bodyText2),
                      Text('활성도 +${profile.equipEngrave![index].point} ', style: Theme.of(context).textTheme.caption)
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          equipEngraves.add(Container());
        }
      });
    } else {
      equipEngraves.add(Container());
      equipEngraves.add(Container());
    }
    print('equipEngraves.length : ${equipEngraves.length}');
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
      child: Row(children: equipEngraves),
    );
  }
}
