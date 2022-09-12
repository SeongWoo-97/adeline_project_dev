import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/model/profile/gem/gem.dart';
import 'package:adeline_app/model/profile/skill/skill.dart';
import 'package:adeline_app/screen/character_search/controller/slot_Color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SkillScreen extends StatefulWidget {
  const SkillScreen({Key? key}) : super(key: key);

  @override
  State<SkillScreen> createState() => _SkillScreenState();
}

class _SkillScreenState extends State<SkillScreen> {
  bool _oneLevelView = false;

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    List<Widget> list = [];
    profile.skillList!.forEach((skill) {
      List<Color> bgColors = slotColor.gradeColors(skill.lun?.grade);
      Color nameColor = slotColor.itemNameColor(skill.lun?.grade);
      List<Gem> gems = [];
      profile.gem?.forEach((element) {
        if (skill.name == element.skill) {
          gems.add(element);
        }
      });
      List<Tripod?> tripods = [skill.tripod1, skill.tripod2, skill.tripod3];
      if (_oneLevelView && skill.level == "1") {
        list.add(Card(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(skill.imgUrl!),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white12),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                skill.type.toString(),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: skill.level?.contains('각성기') != true
                                  ? Text('${skill.name.toString()} Lv.${skill.level} ')
                                  : Text('${skill.name.toString()} '),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(endIndent: 10, thickness: 1.2),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          child: Column(
                            children: [
                              if (skill.lun?.imgUrl != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 7),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: Image.network(skill.lun!.imgUrl!),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.transparent),
                                          borderRadius: BorderRadius.circular(3),
                                          gradient: LinearGradient(
                                            end: Alignment.bottomRight,
                                            begin: Alignment.topLeft,
                                            colors: bgColors,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '[${skill.lun?.tier?.replaceAll('스킬 룬', '').trim()}] ${skill.lun?.title}',
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                    height: 1.2,
                                                    color: nameColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Container(margin: const EdgeInsets.only(bottom: 7)),
                              ListView.builder(
                                itemCount: gems.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  List<Color> gemBgColors = slotColor.gradeColors(gems[index].grade);
                                  Color gemNameColor = slotColor.itemNameColor(gems[index].grade);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          child: Image.network('https://cdn-lostark.game.onstove.com/' + gems[index].imgUrl!),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(3),
                                            gradient: LinearGradient(
                                              end: Alignment.bottomRight,
                                              begin: Alignment.topLeft,
                                              colors: gemBgColors,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Flexible(
                                          child: Text(
                                            '${gems[index].title}',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: gemNameColor),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: ListView.builder(
                            itemCount: tripods.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (tripods[index] != null) {
                                return Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: Image.network('https://cdn-lostark.game.onstove.com/' + tripods[index]!.imgUrl!),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${tripods[index]!.name}', style: Theme.of(context).textTheme.bodyText2),
                                            Text('Lv.${tripods[index]!.level}', style: Theme.of(context).textTheme.bodyText2),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
      } if(!_oneLevelView && skill.level != "1") {
        list.add(Card(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(skill.imgUrl!),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white12),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                skill.type.toString(),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: skill.level?.contains('각성기') != true
                                  ? Text('${skill.name.toString()} Lv.${skill.level} ')
                                  : Text('${skill.name.toString()} '),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(endIndent: 10, thickness: 1.2),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          child: Column(
                            children: [
                              if (skill.lun?.imgUrl != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 7),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: Image.network(skill.lun!.imgUrl!),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.transparent),
                                          borderRadius: BorderRadius.circular(3),
                                          gradient: LinearGradient(
                                            end: Alignment.bottomRight,
                                            begin: Alignment.topLeft,
                                            colors: bgColors,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '[${skill.lun?.tier?.replaceAll('스킬 룬', '').trim()}] ${skill.lun?.title}',
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                height: 1.2,
                                                color: nameColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Container(margin: const EdgeInsets.only(bottom: 7)),
                              ListView.builder(
                                itemCount: gems.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  List<Color> gemBgColors = slotColor.gradeColors(gems[index].grade);
                                  Color gemNameColor = slotColor.itemNameColor(gems[index].grade);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          child: Image.network('https://cdn-lostark.game.onstove.com/' + gems[index].imgUrl!),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(3),
                                            gradient: LinearGradient(
                                              end: Alignment.bottomRight,
                                              begin: Alignment.topLeft,
                                              colors: gemBgColors,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Flexible(
                                          child: Text(
                                            '${gems[index].title}',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: gemNameColor),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: ListView.builder(
                            itemCount: tripods.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (tripods[index] != null) {
                                return Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: Image.network('https://cdn-lostark.game.onstove.com/' + tripods[index]!.imgUrl!),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${tripods[index]!.name}', style: Theme.of(context).textTheme.bodyText2),
                                            Text('Lv.${tripods[index]!.level}', style: Theme.of(context).textTheme.bodyText2),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  ' 사용 스킬 포인트 ${profileProvider.profile.info?.useSkillPoint} / 보유 스킬 포인트 ${profileProvider.profile.info?.haveSkillPoint}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Flexible(
                child: SwitchListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text(
                    "1레벨 스킬보기",
                    textAlign: TextAlign.right,
                  ),
                  activeColor: Colors.tealAccent,
                  value: _oneLevelView,
                  onChanged: (bool value) {
                    setState(() => _oneLevelView = value);
                  },
                ),
              ),
            ],
          ),
        ),
        Column(
          children: list,
        ),
      ],
    );
  }
}
