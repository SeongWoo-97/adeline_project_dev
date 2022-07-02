import 'package:adeline_app/model/profile/accessory_list/accessory/accessory.dart';
import 'package:adeline_app/model/profile/equip_list/armor_equip/armor_equip.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/item_slot/accessory/bracelet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';

class AccessoryWidget extends StatelessWidget {
  const AccessoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    List<Accessory?> accessoryList = [
      profile.accessoryList?.necklace,
      profile.accessoryList?.earring1,
      profile.accessoryList?.earring2,
      profile.accessoryList?.ring1,
      profile.accessoryList?.ring2,
    ];
    Size size = MediaQuery.of(context).size;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              size.width >= 800 ? resAccessorySlotWidget(context, accessoryList) : accessorySlotWidget(context, accessoryList),
        ),
      ),
    );
  }
}

List<Widget> accessorySlotWidget(BuildContext context, List<Accessory?> accessoryList) {
  CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
  CharacterProfile profile = profileProvider.profile;
  List<Widget> list = [];

  if (accessoryList.length != 0) {
    for (int i = 0; i < accessoryList.length; i++) {
      if (accessoryList[i]!.itemName != null) {
        List<Color> bgColors = gradeColors(accessoryList[i]!.grade);
        Color nameColor = itemNameColor(accessoryList[i]!.grade);
        list.add(Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
          child: InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://cdn-lostark.game.onstove.com/' + accessoryList[i]!.itemTitle!.imgUrl.toString(),
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
                    height: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              accessoryList[i]!.itemName.toString(),
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
                          percent: int.parse(accessoryList[i]!.itemTitle!.quality.toString()) * 0.01,
                          center: Text(
                            "${accessoryList[i]!.itemTitle!.quality}",
                            style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          progressColor: qualityColor(accessoryList[i]!.itemTitle!.quality),
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
                            // 아이템 이름
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Center(
                                child: Text(
                                  accessoryList[i]!.itemName.toString(),
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: nameColor),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7, top: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              'https://cdn-lostark.game.onstove.com/' +
                                                  accessoryList[i]!.itemTitle!.imgUrl.toString(),
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
                                                      accessoryList[i]!.itemTitle!.parts.toString(),
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
                                                      accessoryList[i]!.itemTitle!.tier.toString(),
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
                                                  percent: int.parse(accessoryList[i]!.itemTitle!.quality.toString()) * 0.01,
                                                  center: Text(
                                                    "${accessoryList[i]!.itemTitle!.quality}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption
                                                        ?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                                                  ),
                                                  progressColor: qualityColor(accessoryList[i]!.itemTitle!.quality),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7, top: 5),
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
                                  Container(
                                    child: Html(
                                      data: accessoryList[i]!.effect?.basicEffect,
                                      style: {
                                        'html':
                                            Style(fontSize: FontSize(12), margin: EdgeInsets.all(0), padding: EdgeInsets.all(0))
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 7, bottom: 5),
                                      child: Container(
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                          itemCount: accessoryList[i]!.effect!.plusEffect?.split('<BR>').length,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Text('${accessoryList[i]!.effect!.plusEffect?.split('<BR>')[index]}',
                                                style: Theme.of(context).textTheme.caption);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '각인 효과',
                                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                              color: Color(0xFFA9D0F5),
                                            ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 7, bottom: 5),
                                      child: Container(
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                            itemCount: accessoryList[i]?.engrave?.length,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              String name = accessoryList[i]!.engrave![index].name.toString().trim();
                                              return Row(
                                                children: [
                                                  Text('[', style: Theme.of(context).textTheme.caption),
                                                  Text('$name',
                                                      style: Theme.of(context).textTheme.caption?.copyWith(
                                                          color:
                                                              name.indexOf('감소') != -1 ? Color(0xFFFE2E2E) : Color(0xFFFFFFAC))),
                                                  Text('] +${accessoryList[i]!.engrave![index].point}',
                                                      style: Theme.of(context).textTheme.caption),
                                                ],
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
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
        ));
      } else {
        list.add(Padding(
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
                    'https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/bg_equipment_slot${i + 7}.png',
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
        ));
      }
    }
    list.add(BraceletWidget());
  }
  return list;
}

List<Widget> resAccessorySlotWidget(BuildContext context, List<Accessory?> accessoryList) {
  CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
  CharacterProfile profile = profileProvider.profile;
  List<Widget> list = [];

  if (accessoryList.length != 0) {
    for (int i = 0; i < accessoryList.length; i++) {
      if (accessoryList[i]!.itemName != null) {
        List<Color> bgColors = gradeColors(accessoryList[i]!.grade);
        Color nameColor = itemNameColor(accessoryList[i]!.grade);
        list.add(Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
          child: InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://cdn-lostark.game.onstove.com/' + accessoryList[i]!.itemTitle!.imgUrl.toString(),
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
                              accessoryList[i]!.itemName.toString(),
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
                          percent: int.parse(accessoryList[i]!.itemTitle!.quality.toString()) * 0.01,
                          center: Text(
                            "${accessoryList[i]!.itemTitle!.quality}",
                            style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 12),
                          ),
                          progressColor: qualityColor(accessoryList[i]!.itemTitle!.quality),
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
                            // 아이템 이름
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Center(
                                child: Text(
                                  accessoryList[i]!.itemName.toString(),
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: nameColor),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, bottom: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 55,
                                            height: 55,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                'https://cdn-lostark.game.onstove.com/' +
                                                    accessoryList[i]!.itemTitle!.imgUrl.toString(),
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
                                                        accessoryList[i]!.itemTitle!.parts.toString(),
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
                                                        accessoryList[i]!.itemTitle!.tier.toString(),
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
                                                    percent: int.parse(accessoryList[i]!.itemTitle!.quality.toString()) * 0.01,
                                                    center: Text(
                                                      "${accessoryList[i]!.itemTitle!.quality}",
                                                      style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 12),
                                                    ),
                                                    progressColor: qualityColor(accessoryList[i]!.itemTitle!.quality),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // 기본효과, 추가효과, 각인효과
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '기본 효과',
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Color(0xFFA9D0F5)),
                                        ),
                                      ),
                                    ),
                                    Html(
                                      data: accessoryList[i]!.effect?.basicEffect,
                                      style: {
                                        '*': Style(fontSize: FontSize(14),fontFamily: 'NanumGothic',fontWeight: FontWeight.w400),
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
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
                                    // 특성
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8, bottom: 5),
                                        child: Container(
                                          width: double.maxFinite,
                                          child: ListView.builder(
                                            itemCount: accessoryList[i]!.effect!.plusEffect?.split('<BR>').length,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Text('${accessoryList[i]!.effect!.plusEffect?.split('<BR>')[index]}',
                                                  style: Theme.of(context).textTheme.caption);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '각인 효과',
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                color: Color(0xFFA9D0F5),
                                              ),
                                        ),
                                      ),
                                    ),
                                    // 각인효과
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8, bottom: 5),
                                        child: Container(
                                          width: double.maxFinite,
                                          child: ListView.builder(
                                              itemCount: accessoryList[i]?.engrave?.length,
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                String name = accessoryList[i]!.engrave![index].name.toString().trim();
                                                return Row(
                                                  children: [
                                                    Text('[', style: Theme.of(context).textTheme.caption),
                                                    Text('$name',
                                                        style: Theme.of(context).textTheme.caption?.copyWith(
                                                            color: name.indexOf('감소') != -1
                                                                ? Color(0xFFFE2E2E)
                                                                : Color(0xFFFFFFAC))),
                                                    Text('] +${accessoryList[i]!.engrave![index].point}',
                                                        style: Theme.of(context).textTheme.caption),
                                                  ],
                                                );
                                              }),
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
        ));
      } else {
        list.add(Padding(
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
                    'https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/bg_equipment_slot${i + 7}.png',
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
        ));
      }
    }
    list.add(BraceletWidget());
  }
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
        list.add(Color.fromRGBO(220, 201, 153, 1));
        list.add(Color.fromRGBO(61, 51, 37, 1));
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
