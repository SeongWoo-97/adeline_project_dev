import 'package:adeline_app/model/profile/ability_stone/ability_stone.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/slot_Color.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/equip_engrave_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';

class AbilityStoneWidget extends StatelessWidget {
  const AbilityStoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    AbilityStone? stone = profileProvider.profile.abilityStone;
    if (stone?.name != null) {
      List<Color> bgColors = slotColor.gradeColors(stone?.grade);
      Color nameColor = slotColor.itemNameColor(stone!.grade);
      return Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
        child: Column(
          children: [
            InkWell(
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://cdn-lostark.game.onstove.com/' + stone.itemTitle!.imgUrl.toString(),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        end: Alignment.topLeft,
                        begin: Alignment.bottomRight,
                        colors: bgColors,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 5, top: 5),
                      height: 44,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            stone.name.toString(),
                            style: Theme.of(context).textTheme.caption?.copyWith(
                                  height: 1.2,
                                  color: nameColor,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: stone.effect?.engraveEffect?.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                String? name = stone.effect?.engraveEffect![index].name!.trim();
                                Color color = name!.indexOf('감소') != -1 ? Color(0xFFFE2E2E) : Color(0xFFFFFFAC);
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$name', style: Theme.of(context).textTheme.caption?.copyWith(color: color)),
                                    Text(' +${stone.effect?.engraveEffect![index].point!}',
                                        style: Theme.of(context).textTheme.caption),
                                    name.indexOf('감소') == -1
                                        ? Text('  ', style: Theme.of(context).textTheme.caption)
                                        : Container()
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                showPlatformDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                      content: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Center(
                                  child: Text(
                                    stone.name.toString(),
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: nameColor),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7, bottom: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 45,
                                            height: 45,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                'https://cdn-lostark.game.onstove.com/' + stone.itemTitle!.imgUrl.toString(),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(8),
                                              gradient: LinearGradient(
                                                end: Alignment.topLeft,
                                                begin: Alignment.bottomRight,
                                                colors: bgColors,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                              height: 45,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 5),
                                                    child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        stone.itemTitle!.parts.toString(),
                                                        style: Theme.of(context).textTheme.caption?.copyWith(
                                                              height: 1.2,
                                                              color: nameColor,
                                                            ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 5),
                                                    child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        stone.itemTitle!.tier.toString(),
                                                        style: Theme.of(context).textTheme.caption?.copyWith(
                                                              height: 1.2,
                                                            ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '기본 효과',
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                color: Color(0xFFA9D0F5),
                                              ),
                                        ),
                                      ),
                                      Text('${stone.effect!.basicEffect.toString()}', style: Theme.of(context).textTheme.caption),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '추가 효과',
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                color: Color(0xFFA9D0F5),
                                              ),
                                        ),
                                      ),
                                      Text('${stone.effect!.plusEffect.toString()}', style: Theme.of(context).textTheme.caption),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '무작위 각인 효과',
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                color: Color(0xFFA9D0F5),
                                              ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          width: double.maxFinite,
                                          child: ListView.builder(
                                            itemCount: stone.effect?.engraveEffect?.length,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              String? name = stone.effect?.engraveEffect![index].name!.trim();
                                              String? point = stone.effect?.engraveEffect![index].point!.trim();
                                              Color color = name!.indexOf('감소') != -1 ? Color(0xFFFE2E2E) : Color(0xFFFFFFAC);
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('[', style: Theme.of(context).textTheme.caption),
                                                  Text('$name',
                                                      style: Theme.of(context).textTheme.caption?.copyWith(
                                                          color:
                                                              name.indexOf('감소') != -1 ? Color(0xFFFE2E2E) : Color(0xFFFFFFAC))),
                                                  Text('] +${point}', style: Theme.of(context).textTheme.caption),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Divider(endIndent: 10, indent: 5),
            EquipEngraveWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Divider(endIndent: 10, indent: 5, height: 1),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/bg_equipment_slot12.png',
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 5),
                  height: 44,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          '장착된 아이템 없음',
                          style: Theme.of(context).textTheme.caption?.copyWith(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(endIndent: 10, indent: 5, height: 1),
          ),
          EquipEngraveWidget(),
        ],
      ),
    );
  }
}
