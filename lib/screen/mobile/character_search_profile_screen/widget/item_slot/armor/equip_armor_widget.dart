import 'package:adeline_app/model/profile/equip_list/armor_equip/armor_equip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';

import '../weapon/equip_weapon_widget.dart';

class EquipWidget extends StatelessWidget {
  const EquipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
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

List<Widget> armorSlotWidget(BuildContext context, List<ArmorEquip?> armorEquips) {
  CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
  CharacterProfile profile = profileProvider.profile;
  List<Widget> list = [];
  for (int i = 0; i < armorEquips.length; i++) {
    if (armorEquips[i] != null) {
      List<Color> bgColors = gradeColors(armorEquips[i]!.grade);
      Color nameColor = itemNameColor(armorEquips[i]!.grade);
      List<String?> tripods = [armorEquips[i]!.tripod!.tripod1, armorEquips[i]!.tripod!.tripod2, armorEquips[i]!.tripod!.tripod3];
      list.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
        child: InkWell(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://cdn-lostark.game.onstove.com/' + armorEquips[i]!.itemTitle!.imgUrl.toString(),
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
                            style: Theme.of(context).textTheme.caption?.copyWith(
                                  height: 1.2,
                                  color: nameColor,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      LinearPercentIndicator(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        animation: true,
                        lineHeight: 16.0,
                        animationDuration: 1500,
                        backgroundColor: Colors.grey,
                        percent: int.parse(armorEquips[i]!.itemTitle!.quality.toString()) * 0.01,
                        center: Text(
                          "${armorEquips[i]!.itemTitle!.quality}",
                          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        progressColor: qualityColor(armorEquips[i]!.itemTitle!.quality),
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
                                  armorEquips[i]!.itemName.toString(),
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: nameColor),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 기본효과
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              'https://cdn-lostark.game.onstove.com/' +
                                                  armorEquips[i]!.itemTitle!.imgUrl.toString(),
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
                                            height: 50,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5),
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      armorEquips[i]!.itemTitle!.parts.toString(),
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
                                                      armorEquips[i]!.itemTitle!.itemLevel.toString(),
                                                      style: Theme.of(context).textTheme.caption?.copyWith(
                                                            height: 1.2,
                                                          ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                LinearPercentIndicator(
                                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                  animation: false,
                                                  lineHeight: 16.0,
                                                  backgroundColor: Colors.grey,
                                                  percent: int.parse(armorEquips[i]!.itemTitle!.quality.toString()) * 0.01,
                                                  center: Text(
                                                    "${armorEquips[i]!.itemTitle!.quality}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption
                                                        ?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                                                  ),
                                                  progressColor: qualityColor(armorEquips[i]!.itemTitle!.quality),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '기본 효과',
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                color: Color(0xFFA9D0F5),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                            itemCount: armorEquips[i]!.effect!.basicEffect.length,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Text(armorEquips[i]!.effect!.basicEffect[index],
                                                  style: Theme.of(context).textTheme.caption);
                                            }),
                                      ),
                                    ),
                                    // 추가효과
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '추가 효과',
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                color: Color(0xFFA9D0F5),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                            itemCount: armorEquips[i]!.effect!.plusEffect.length,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Text(armorEquips[i]!.effect!.plusEffect[index],
                                                  style: Theme.of(context).textTheme.caption);
                                            }),
                                      ),
                                    ),
                                    // 트라이포드 효과
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '트라이포드 효과',
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                color: Color(0xFFA9D0F5),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                            itemCount: tripods.length,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Text(tripods[index]!.replaceAll('[${profile.info!.job}]', '').trim(),
                                                  style: Theme.of(context).textTheme.caption);
                                            }),
                                      ),
                                    ),
                                    // 세트 효과
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '세트 효과',
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Color(0xFFA9D0F5)),
                                        ),
                                      ),
                                    ),
                                    Text('${armorEquips[i]!.setLevel}', style: Theme.of(context).textTheme.caption)
                                  ],
                                ),
                              ),
                            ),
                            armorEquips[i]!.setEffect == null
                                ? Container()
                                : Container(
                                    child: Html(data: armorEquips[i]!.setEffect, style: {'font': Style(fontSize: FontSize(12))}))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ));
    } else {
      list.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/bg_equipment_slot${i + 1}.png',
                ),
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
                          '장착된 아이템 없음',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.2,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    LinearPercentIndicator(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      animation: false,
                      lineHeight: 16.0,
                      animationDuration: 1500,
                      backgroundColor: Colors.grey,
                      percent: 0,
                      center: Text(
                        "0",
                        style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      progressColor: Colors.amber,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ));
    }
  }
  list.add(WeaponWidget());
  return list;
}

List<Color> gradeColors(int? grade) {
  List<Color> list = [];
  if (grade != null) {
    switch (grade) {
      case 1:
        list.add(Colors.white);
        break;
      case 2: // 희귀
        list.add(Color.fromRGBO(17, 31, 44, .7));
        list.add(Color.fromRGBO(17, 61, 93, 1));
        break;
      case 3: // 영웅
        list.add(Color.fromRGBO(72, 13, 93, .8));
        list.add(Color.fromRGBO(38, 19, 49, 1));
        break;
      case 4: // 전설
        list.add(Color.fromRGBO(158, 95, 4, .9));
        list.add(Color.fromRGBO(54, 32, 3, .85));
        break;
      case 5: // 유물
        list.add(Color.fromRGBO(162, 64, 6, 1));
        list.add(Color.fromRGBO(52, 26, 9, 1));
        break;
      case 6: // 고대
        list.add(Color.fromRGBO(61, 51, 37, .6));
        list.add(Color.fromRGBO(220, 201, 153, 1));
        break;
      case 7: // 에스더
        list.add(Color.fromRGBO(12, 46, 44, .6));
        list.add(Color.fromRGBO(47, 171, 168, 1));
        break;
      default:
        list.add(Colors.white);
        break;
    }
  }
  return list;
}

Color itemNameColor(int? grade) {
  Color color = Colors.grey;
  if (grade != null) {
    switch (grade) {
      case 1: // 고급
        break;
      case 2: // 희귀
        color = Color(0xFF00B0FA);
        break;
      case 3: // 영웅
        color = Color(0xFFce43fc);
        break;
      case 4: // 전설
        color = Color(0xFFF99200);
        break;
      case 5: // 유물
        color = Color(0xFFFA5D00);
        break;
      case 6: // 고대
        color = Color(0xFFE3C7A1);
        break;
      case 7: // 에스더
        color = Color(0xFF3CF2E6);
        break;
      default:
        break;
    }
  }
  return color;
}

Color qualityColor(int? quality) {
  Color color = Colors.greenAccent;
  if (quality != null) {
    if (quality >= 0 && quality <= 9) {
      color = Color.fromRGBO(255, 96, 0, 1);
    }
    if (quality >= 10 && quality <= 29) {
      color = Color.fromRGBO(255, 210, 0, 1);
    }
    if (quality >= 30 && quality <= 69) {
      color = Color.fromRGBO(145, 254, 2, 1);
    }
    if (quality >= 70 && quality <= 89) {
      color = Color.fromRGBO(0, 181, 255, 1);
    }
    if (quality >= 90 && quality <= 99) {
      color = Color.fromRGBO(206, 67, 252, 1);
    }
    if (quality == 100) {
      color = Color.fromRGBO(254, 150, 0, 1);
    }
  }
  return color;
}
