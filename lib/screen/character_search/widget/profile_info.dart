import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/profile/character_profile_provider.dart';

class ProfileInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    return Card(
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Lv.${profile.info?.battleLevel} ${profile.info?.nickName}',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18),
                ),
                Text(' (${profile.info?.server})',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14))
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('클  래  스  : ${profile.info?.job}'),
                        Text('원  정  대  : ${profile.info?.expeditionLevel}'),
                        Text('장착 레벨 : ${profile.info?.achieveItemLevel.replaceFirst("Lv.", "")}'),
                        Text('달성 레벨 : ${profile.info?.achieveItemLevel.replaceFirst("Lv.", "")}'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text('길드 : ${profile.info?.guild}', overflow: TextOverflow.ellipsis),
                      ),
                      Text('PVP : ${profile.info?.pvp}'),
                      Text('칭호 : ${profile.info?.badge}'),
                      Container(
                        child: Text(
                            '영지 : ${profile.info?.fief.fiefLevel} ${profile.info?.fief.fiefName}',
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
