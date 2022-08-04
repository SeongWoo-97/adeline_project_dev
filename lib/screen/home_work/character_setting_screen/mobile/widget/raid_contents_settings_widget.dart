import 'package:adeline_app/model/toast/toast.dart';
import 'package:adeline_app/model/user/content/raid_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/dark_mode/dark_theme_provider.dart';
import '../../../../../model/user/user_provider.dart';

class RaidContentSettingWidget extends StatefulWidget {
  final int characterIndex;

  RaidContentSettingWidget(this.characterIndex);

  @override
  State<RaidContentSettingWidget> createState() => _RaidContentSettingWidgetState();
}

class _RaidContentSettingWidgetState extends State<RaidContentSettingWidget> {

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    print('레이드콘텐츠 길이(Mobile) : ${userProvider.charactersProvider.characters[widget.characterIndex].raidContents.length}');

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: userProvider.charactersProvider.characters[widget.characterIndex].raidContents.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            RaidContent raidContent = userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey, width: 0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: iconPerType(raidContent.type),
                              ),
                              Text(
                                '[${raidContent.type}] ${raidContent.name}',
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                              ),
                              difficultyText(userProvider
                                  .charactersProvider.characters[widget.characterIndex].raidContents[index].difficulty
                                  .toString()),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '클리어 기준 : ${userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index].clearCheckStandardPhase} 관문',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(width: 5),
                                InkWell(
                                  child: Image.asset(
                                    'assets/etc/math_plus.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      int clearCheckStandardPhase = userProvider
                                          .charactersProvider.characters[widget.characterIndex].raidContents[index].clearCheckStandardPhase;
                                      int totalPhase =
                                          userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index].totalPhase;
                                      if (clearCheckStandardPhase < totalPhase) {
                                        userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index]
                                            .clearCheckStandardPhase += 1;
                                      } else {
                                        ToastMessage.toast('최대 관문수를 초과할수 없습니다.');
                                      }
                                    });
                                  },
                                ),
                                SizedBox(width: 5),
                                InkWell(
                                  child: Image.asset(
                                    'assets/etc/math_minus.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      int clearCheckStandardPhase = userProvider
                                          .charactersProvider.characters[widget.characterIndex].raidContents[index].clearCheckStandardPhase;
                                      int totalPhase =
                                          userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index].totalPhase;
                                      if (clearCheckStandardPhase > 1) {
                                        userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index]
                                            .clearCheckStandardPhase -= 1;
                                      }
                                      if (clearCheckStandardPhase <= 1) {
                                        ToastMessage.toast('1관문 보다 적게 설정하실수 없습니다.');
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          value: userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index].isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index].isChecked = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget iconPerType(String type) {
    switch (type) {
      case "군단장":
        return Image.asset("assets/week/Crops.png", width: 25, height: 25);
      case "오레하":
        return Image.asset("assets/week/AbyssDungeon.png", width: 25, height: 25);
      case "카양겔":
        return Image.asset("assets/week/AbyssDungeon.png", width: 25, height: 25);
      case "어비스 레이드":
        return Image.asset("assets/week/AbyssRaid.png", width: 25, height: 25);
    }
    return Image.asset("assets/week/AbyssRaid.png", width: 25, height: 25);
  }

  Widget difficultyText(String name) {
    if (name.isEmpty) {
      return Container();
    } else {
      switch (name) {
        case "노말":
          return Container(
              margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                border: Border.all(color: DarkMode.isDarkMode.value ? Colors.green : Colors.greenAccent),
                color: DarkMode.isDarkMode.value ? Colors.green : Colors.greenAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                child: Text(
                  '$name',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ));
        case "하드":
          return Container(
              margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                border: Border.all(color: DarkMode.isDarkMode.value ? Colors.red : Colors.redAccent.shade200),
                color: DarkMode.isDarkMode.value ? Colors.red : Colors.redAccent.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                child: Text(
                  '$name',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ));
      }
    }
    return Container();
  }

  int clearGoldTotal(List<int> list) {
    int clearGold = 0;
    list.forEach((element) {
      clearGold += element;
    });
    return clearGold;
  }

  int clearGoldIndex(List<int> list, int index) {
    int clearGold = 0;
    for (int i = 0; i <= index; i++) {
      clearGold += list[i];
    }
    return clearGold;
  }
}
