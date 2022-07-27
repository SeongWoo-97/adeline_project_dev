import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AbilityInfoWidget extends StatelessWidget {
  const AbilityInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '기본 특성',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Color(0xFFA9D0F5)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5,top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('공격력'),
                            Text('최대 생명력'),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${NumberFormat('###,###,###,###').format(int.parse(profile.attackBasic!.attackNumber!))}'),
                            Text('${NumberFormat('###,###,###,###').format(int.parse(profile.attackBasic!.maxLifeNumber!))}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5,top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '전투 특성',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Color(0xFFA9D0F5)),

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5,top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          child: Column(
                            children: [Text('치명'), Text('특화'), Text('신속')],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityBattle!.critical!))}'),
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityBattle!.specialty!))}'),
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityBattle!.agility!))}'),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            children: [Text('제압'), Text('인내'), Text('숙련')],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityBattle!.subdue!))}'),
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityBattle!.endurance!))}'),
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityBattle!.proficiency!))}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5,top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '성향',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Color(0xFFA9D0F5)),

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5,top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          child: Column(
                            children: [Text('지성'), Text('담력')],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityTendecy!.intellect!))}'),
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityTendecy!.bravery!))}'),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            children: [Text('매력'), Text('친절')],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityTendecy!.charm!))}'),
                              Text('${NumberFormat('###,###,###,###').format(int.parse(profile.abilityTendecy!.kindness!))}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
