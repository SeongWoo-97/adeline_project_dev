import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/model/profile/equip_list/weapon/weapon.dart';
import 'package:adeline_app/screen/character_search/controller/slot_Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class WeaponWidget extends StatelessWidget {
  const WeaponWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    Size size = MediaQuery.of(context).size;
    if (profile.equipList?.weapon != null) {
      Weapon? weapon = profile.equipList?.weapon;
      List<Color> bgColors = slotColor.gradeColors(weapon!.grade);
      Color nameColor = slotColor.itemNameColor(weapon.grade);
      return size.width >= 800
          ? InkWell(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://cdn-lostark.game.onstove.com/' + weapon.itemTitle!.imgUrl.toString(),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        end: Alignment.bottomRight,
                        begin: Alignment.topLeft,
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
                                weapon.itemName.toString(),
                                style: Theme.of(context).textTheme.caption?.copyWith(height: 1.2, color: nameColor),
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
                            percent: int.parse(weapon.itemTitle!.quality.toString()) * 0.01,
                            center: Text(
                              "${weapon.itemTitle!.quality}",
                              style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 12),
                            ),
                            progressColor: slotColor.qualityColor(weapon.itemTitle!.quality),
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Center(
                                    child: Text(
                                      weapon.itemName.toString(),
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 55,
                                              height: 55,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.network(
                                                  'https://cdn-lostark.game.onstove.com/' + weapon.itemTitle!.imgUrl.toString(),
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
                                                height: 55,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5),
                                                      child: Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          weapon.itemTitle!.parts.toString(),
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
                                                          weapon.itemTitle!.itemLevel.toString(),
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
                                                      percent: int.parse(weapon.itemTitle!.quality.toString()) * 0.01,
                                                      center: Text(
                                                        "${weapon.itemTitle!.quality}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            ?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                                                      ),
                                                      progressColor: slotColor.qualityColor(weapon.itemTitle!.quality),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        // 기본효과, 추가효과, 트라이포드 효과, 세트 효과
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '기본 효과',
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Color(0xFFA9D0F5)),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text("무기 공격력 +${weapon.effect!.basicEffect!}",
                                              style: Theme.of(context).textTheme.caption),
                                        ),
                                        // 추가효과
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '추가 효과',
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Color(0xFFA9D0F5)),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            width: double.maxFinite,
                                            child: ListView.builder(
                                                itemCount: weapon.effect!.plusEffect.length,
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Text(weapon.effect!.plusEffect[index],
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
                                        Text('${weapon.setLevel}', style: Theme.of(context).textTheme.caption)
                                      ],
                                    ),
                                  ),
                                ),
                                weapon.setEffect == null
                                    ? Container()
                                    : Container(
                                        child: Html(
                                          data: weapon.setEffect,
                                          style: {
                                            'font':
                                            Style(fontSize: FontSize(14), fontWeight: FontWeight.w400, fontFamily: 'NanumGothic'),
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            )
          : InkWell(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://cdn-lostark.game.onstove.com/' + weapon.itemTitle!.imgUrl.toString(),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        end: Alignment.bottomRight,
                        begin: Alignment.topLeft,
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
                                weapon.itemName.toString(),
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
                            percent: int.parse(weapon.itemTitle!.quality.toString()) * 0.01,
                            center: Text(
                              "${weapon.itemTitle!.quality}",
                              style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            progressColor: slotColor.qualityColor(weapon.itemTitle!.quality),
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
                                      weapon.itemName.toString(),
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
                                                  'https://cdn-lostark.game.onstove.com/' + weapon.itemTitle!.imgUrl.toString(),
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
                                                          weapon.itemTitle!.parts.toString(),
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
                                                          weapon.itemTitle!.itemLevel.toString(),
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
                                                      percent: int.parse(weapon.itemTitle!.quality.toString()) * 0.01,
                                                      center: Text(
                                                        "${weapon.itemTitle!.quality}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            ?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                                                      ),
                                                      progressColor: slotColor.qualityColor(weapon.itemTitle!.quality),
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
                                          child: Text("무기 공격력 +${weapon.effect!.basicEffect!}",
                                              style: Theme.of(context).textTheme.caption),
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
                                                itemCount: weapon.effect!.plusEffect.length,
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Text(weapon.effect!.plusEffect[index],
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
                                        Text('${weapon.setLevel}', style: Theme.of(context).textTheme.caption)
                                      ],
                                    ),
                                  ),
                                ),
                                weapon.setEffect == null
                                    ? Container()
                                    : Container(
                                        child: Html(data: weapon.setEffect, style: {'font': Style(fontSize: FontSize(12))}))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/bg_equipment_slot6.png',
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
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
      );
    }
  }
}
