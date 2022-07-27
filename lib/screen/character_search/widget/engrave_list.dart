import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EngraveEffectWidget extends StatelessWidget {
  const EngraveEffectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    int length = profileProvider.profile.abilityEngraveList!.engraveName!.length;
    List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      String engraveName = profileProvider.profile.abilityEngraveList!.engraveName![i].replaceAll(':', '').split('Lv.')[0].trim();
      list.add(Container(
        height: 35,
        margin: EdgeInsets.all(5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ClipOval(
                child: Image.asset('assets/engrave/${engraveName}.png'),
              ),
            ),
            Text('${profileProvider.profile.abilityEngraveList!.engraveName![i]}')
          ],
        ),
      ));
    }
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '각인 효과',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Color(0xFFA9D0F5)),
                ),
              ],
            ),
            Column(mainAxisSize: MainAxisSize.min, children: list),
          ],
        ),
      ),
    );
  }
}
