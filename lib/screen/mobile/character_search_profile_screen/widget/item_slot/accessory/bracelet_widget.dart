import 'package:adeline_app/model/profile/accessory_list/bracelet/bracelet.dart';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/slot_Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class BraceletWidget extends StatelessWidget {
  const BraceletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CharacterProfileProvider profileProvider = Provider.of<CharacterProfileProvider>(context, listen: false);
    CharacterProfile profile = profileProvider.profile;
    Bracelet? bracelet = profile.accessoryList?.bracelet;

    if (profile.accessoryList?.bracelet!.name != null) {
      List<Color> bgColors = slotColor.gradeColors(bracelet!.grade);
      Color nameColor = slotColor.itemNameColor(bracelet.grade);
      return InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://cdn-lostark.game.onstove.com/' + bracelet.itemTitle!.imgUrl.toString(),
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
                          bracelet.name.toString(),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.2,
                                color: nameColor,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container()
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
                                bracelet.name.toString(),
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: nameColor),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 7,bottom: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // 아이템 이미지
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            'https://cdn-lostark.game.onstove.com/' + bracelet.itemTitle!.imgUrl.toString(),
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
                                      // 아이템 부위 (parts)
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
                                                    bracelet.itemTitle!.parts.toString(),
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
                                                    bracelet.itemTitle!.tier.toString(),
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '팔찌 효과',
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
                                          itemCount: bracelet.effect!.length,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Text(bracelet.effect![index].trim(),
                                                style: Theme.of(context).textTheme.caption);
                                          }),
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
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/bg_equipment_slot19.png',
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
      );
    }
  }
}
