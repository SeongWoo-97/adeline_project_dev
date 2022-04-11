import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/user/character/character_model.dart';
import '../../../../model/user/content/gold_content.dart';
import '../../../../model/user/user_provider.dart';

class GoldContentSettingWidget extends StatefulWidget {
  final int characterIndex;

  GoldContentSettingWidget(this.characterIndex);

  @override
  State<GoldContentSettingWidget> createState() => _GoldContentSettingWidgetState();
}

class _GoldContentSettingWidgetState extends State<GoldContentSettingWidget> {
  List<GoldContent> defaultGoldContents =
      List.generate(constGoldContents.length, (index) => GoldContent.clone(constGoldContents[index]));

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.charactersProvider.characters[widget.characterIndex].goldContents.length == 0) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('해당 캐릭터는 골드 콘텐츠가 설정되어 있지 않습니다.'),
                    Text('콘텐츠를 선택하신후 저장 버튼을 눌러주세요!'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                    onPressed: () {
                      userProvider.charactersProvider.characters[widget.characterIndex].goldContents = defaultGoldContents;
                      userProvider.updateContentBoard();
                    },
                    child: Text('저장')),
              )
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: defaultGoldContents.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
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
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: iconPerType(defaultGoldContents[index].type),
                            ),
                            Text(
                              '${defaultGoldContents[index].name}',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                            ),
                            difficultyText(defaultGoldContents[index].difficulty.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text('${clearGoldTotal(defaultGoldContents[index].goldPerPhase)} Gold',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15)),
                            ),
                            SizedBox(
                              height: 25,
                              child: Checkbox(
                                value: defaultGoldContents[index].isChecked,
                                onChanged: (bool? value) {
                                  print(value);
                                  setState(() {
                                    defaultGoldContents[index].isChecked = value!;
                                  });
                                },
                              ),
                            )
                          ],
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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ElevatedButton(
                  onPressed: () {
                    userProvider.charactersProvider.characters[widget.characterIndex].goldContents = defaultGoldContents;
                    userProvider.updateContentBoard();
                  },
                  child: Text('저장')),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: userProvider.charactersProvider.characters.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
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
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: iconPerType(
                                userProvider.charactersProvider.characters[widget.characterIndex].goldContents[index].type),
                          ),
                          Text(
                            '${userProvider.charactersProvider.characters[widget.characterIndex].goldContents[index].name}',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                          ),
                          difficultyText(userProvider
                              .charactersProvider.characters[widget.characterIndex].goldContents[index].difficulty
                              .toString()),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                                '${clearGoldTotal(userProvider.charactersProvider.characters[widget.characterIndex].goldContents[index].goldPerPhase)} Gold',
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15)),
                          ),
                          SizedBox(
                            height: 25,
                            child: Checkbox(
                              value:
                                  userProvider.charactersProvider.characters[widget.characterIndex].goldContents[index].isChecked,
                              onChanged: (bool? value) {
                                print(value);
                                setState(() {
                                  userProvider.charactersProvider.characters[widget.characterIndex].goldContents[index]
                                      .isChecked = value!;
                                });
                              },
                            ),
                          )
                        ],
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
      case "어비스 던전":
        return Image.asset("assets/week/AbyssDungeon.png", width: 25, height: 25);
      case "어비스 레이드":
        return Image.asset("assets/week/AbyssRaid.png", width: 25, height: 25);
    }
    return Image.asset("assets/week/Crops.png", width: 25, height: 25);
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
                border: Border.all(color: Colors.greenAccent),
                color: Colors.greenAccent,
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
                border: Border.all(color: Colors.redAccent.shade200),
                color: Colors.redAccent.shade200,
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

  String clearGoldPerCharacter(Character character, int index) {
    int level = int.parse(character.level);
    bool getGoldLevelLimit = level <= character.goldContents[index].getGoldLevelLimit; // 골드획득 레벨제한
    bool enterGoldLevelLimit = level >= character.goldContents[index].enterLevelLimit;
    bool clearCheck = character.goldContents[index].clearChecked;
    print(getGoldLevelLimit);
    if (getGoldLevelLimit && character.goldContents[index].characterAlwaysMaxClear && enterGoldLevelLimit) {
      int total = 0;
      character.goldContents[index].goldPerPhase.forEach((element) {
        total += element;
      });
      return total.toString() + " Gold";
    }
    if (getGoldLevelLimit &&
        character.goldContents[index].characterAlwaysMaxClear == false &&
        enterGoldLevelLimit &&
        clearCheck) {
      return "${character.goldContents[index].clearGold} Gold";
    }
    if (getGoldLevelLimit && character.goldContents[index].characterAlwaysMaxClear == false && enterGoldLevelLimit) {
      return "관문 선택";
    }
    if (level < character.goldContents[index].enterLevelLimit) {
      return "입장레벨 제한";
    }
    return "골드획득 불가";
  }
}
