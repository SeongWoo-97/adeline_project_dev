import 'package:adeline_app/model/profile/equip_list/armor_equip/armor_equip.dart';
import 'package:adeline_app/model/profile/equip_list/weapon/weapon.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../model/profile/character_profile.dart';
import '../../../../model/profile/character_profile_provider.dart';

class EquipWidget extends StatelessWidget {
  const EquipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider =
        Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    List<ArmorEquip?> armorEquips = [
      profile.equipList?.head,
      profile.equipList?.shoulder,
      profile.equipList?.top,
      profile.equipList?.bottom,
      profile.equipList?.gloves,
    ];
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: armorSlotWidget(context, armorEquips),
        ),
      ),
    );
  }
}

// 1. 배열에 방어구 값을 한번만 넣으면 그 이후 배열을 이용해 작성 가능
// 2. null 체크 - null 이면 빈 슬롯 이미지 반환
// 3. 장비 등급에 따른 색깔 값 변환 장비 등급은 (1~6등급이 있다.)
// 4.
List<Widget> armorSlotWidget(BuildContext context, List<ArmorEquip?> armorEquips) {
  List<Widget> list = [];

  for (int i = 0; i < armorEquips.length; i++) {
    if (armorEquips[i] != null) {
      int? grade = armorEquips[i]!.grade;
      list.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
        child: InkWell(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                child: Image.network(
                  'https://cdn-lostark.game.onstove.com/' +
                      armorEquips[i]!.itemTitle!.imgUrl.toString(),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    end: Alignment.topLeft,
                    begin: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(61, 51, 37, .6),
                      Color.fromRGBO(220, 201, 153, 1),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            armorEquips[i]!.itemName.toString(),
                            style: Theme.of(context).textTheme.caption?.copyWith(height: 1.2),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      LinearPercentIndicator(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        animation: true,
                        lineHeight: 16.0,
                        animationDuration: 1500,
                        percent: int.parse(armorEquips[i]!.itemTitle!.quality.toString()) * 0.01,
                        center: Text(
                          "${armorEquips[i]!.itemTitle!.quality}",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        progressColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    } else {
      list.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            child: Image.network(
              // https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/bg_equipment_slot1.png
              // https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/bg_equipment_slot2.png
              'https://cdn-lostark.game.onstove.com/' +
                  armorEquips[i]!.itemTitle!.imgUrl.toString(),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(61, 51, 37, .6),
                  Color.fromRGBO(220, 201, 153, 1),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '아이템 없음',
                        style: Theme.of(context).textTheme.caption?.copyWith(height: 1.2),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ));
    }
  }
  return list;
}

List<Color> gradeColors(int? grade) {
  List<Color> list = [];
  if (grade != null) {
    switch (grade) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        list.add(Color.fromRGBO(61, 51, 37, .6));
        list.add(Color.fromRGBO(220, 201, 153, 1));
        break;
      default :
        list.add(Colors.transparent);
        break;
    }
  }
  return list;
}
