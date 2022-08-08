import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/user/expedition/expedition_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../model/user/character/character_model.dart';
import '../../../../../../model/user/content/raid_content.dart';
import '../../../../../../model/user/user_provider.dart';

class NotMobileRaidContentsWidget extends StatefulWidget {
  final int characterIndex;
  final defaultRaidContents;

  const NotMobileRaidContentsWidget(this.characterIndex, this.defaultRaidContents);

  @override
  State<NotMobileRaidContentsWidget> createState() => _NotMobileRaidContentsWidgetState();
}

class _NotMobileRaidContentsWidgetState extends State<NotMobileRaidContentsWidget> {
  AddGoldType _goldType = AddGoldType.normal;
  int busCost = 0;
  TextEditingController addGoldTextEditingController = TextEditingController();
  TextEditingController minusGoldTextEditingController = TextEditingController();

  final expeditionBox = Hive.box<Expedition>(hiveExpeditionName);
  List<RaidContent> defaultRaidContents = [];

  @override
  Widget build(BuildContext context) {
    int characterIndex = widget.characterIndex;
    defaultRaidContents = widget.defaultRaidContents;
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    Character character = userProvider.charactersProvider.characters[characterIndex];
    List<RaidContent> raidContents = character.raidContents;
    if (raidContents.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 9, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('원하시는 레이드 콘텐츠를 체크하신 후 \n"저장" 버튼을 눌러주세요!', style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 5, bottom: 5),
              child: ElevatedButton(
                child: Text('저장', style: Theme.of(context).textTheme.bodyText2),
                onPressed: () => userProvider.setRaidContents(context, characterIndex, defaultRaidContents),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / .5,
              mainAxisSpacing: 5,
            ),
            itemCount: defaultRaidContents.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey, width: 0.8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 5),
                            child: iconPerType(defaultRaidContents[index].type),
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                '${defaultRaidContents[index].name}',
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: difficultyText(defaultRaidContents[index].name), overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            height: 25,
                            width: 25,
                            child: Checkbox(
                              value: defaultRaidContents[index].isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  defaultRaidContents[index].isChecked = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: raidContents.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (raidContents[index].isChecked == true) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: InkWell(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: totalClearCheck(raidContents[index]) ? Colors.green : Colors.grey)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                iconPerType(raidContents[index].type),
                                SizedBox(width: 2),
                                Text('${raidContents[index].name}',
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(height: 1)),
                              ],
                            ),
                            Text(
                              'Gold ${NumberFormat('###,###,###,###').format(clearGoldIndex(raidContents[index], character.nickName))} G',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 5),
                            Text("추가 골드 : ${NumberFormat('###,###,###,###').format(raidContents[index].addGold)} G",
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14)),
                            SizedBox(width: 3),
                            InkWell(
                              child: Icon(
                                Icons.add,
                                color: Colors.indigoAccent,
                                size: 23,
                              ),
                              onTap: () => addGoldAlertDialog(context, index),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        List<Widget> list = [];
                        for (int difficultyIndex = 0;
                            difficultyIndex < raidContents[index].difficulty.length;
                            difficultyIndex++) {
                          String difficulty = raidContents[index].difficulty[difficultyIndex];
                          // 첫번째 인스턴스는 왼쪽 구분행을 포함하여 반환 (구분행 - 전체, 1관문, 2관문 같은 것)
                          if (difficultyIndex == 0) {
                            list.add(Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // 난이도
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    '${raidContents[index].difficulty[difficultyIndex]}',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                          color: difficultyText(raidContents[index].difficulty[difficultyIndex]),
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // index 0, 클리어 열
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5),
                                            child: Text('클리어'),
                                          ),
                                          Container(
                                            width: 87,
                                            height: 50 * (raidContents[index].totalPhase + 1),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: raidContents[index].totalPhase + 1,
                                              itemBuilder: (context, phaseIndex) {
                                                // 클리어 전체 버튼
                                                if (phaseIndex == 0) {
                                                  bool isTotalCheck = true;
                                                  userProvider
                                                      .charactersProvider.characters[characterIndex].raidContents[index].clearList
                                                      .forEach((element) {
                                                    if (!(element.check) || element.difficulty != difficulty) {
                                                      isTotalCheck = false;
                                                    }
                                                  });
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text('전체'),
                                                      Container(
                                                        width: 48,
                                                        height: 48,
                                                        child: Checkbox(
                                                            value: isTotalCheck,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                userProvider.checkRaidClearCheck(
                                                                    characterIndex, index, difficulty, phaseIndex, value!);
                                                              });
                                                            }),
                                                      ),
                                                    ],
                                                  );
                                                } else {
                                                  bool isChecked = false;
                                                  List<CheckHistory?> list = userProvider.charactersProvider
                                                      .characters[characterIndex].raidContents[index].clearList;
                                                  if (list[phaseIndex - 1]!.check &&
                                                      list[phaseIndex - 1]!.difficulty == difficulty) {
                                                    isChecked = true;
                                                  }
                                                  return Row(
                                                    children: [
                                                      Text('${phaseIndex}관문'),
                                                      Container(
                                                        width: 48,
                                                        height: 48,
                                                        child: Checkbox(
                                                            value: isChecked,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                userProvider.checkRaidClearCheck(
                                                                    characterIndex, index, difficulty, phaseIndex, value!);
                                                              });
                                                            }),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // index 0, 더보기 열
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('더보기'),
                                          Container(
                                            width: 60,
                                            height: 50 * (raidContents[index].totalPhase + 1),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: raidContents[index].totalPhase + 1,
                                              itemBuilder: (context, phaseIndex) {
                                                // 더보기 전체 버튼
                                                bool isBonusCheck = false;
                                                if (phaseIndex == 0) {
                                                  bool isBonusCheck = true;
                                                  userProvider
                                                      .charactersProvider.characters[characterIndex].raidContents[index].bonusList
                                                      .forEach((element) {
                                                    if (!(element.check) || element.difficulty != difficulty) {
                                                      isBonusCheck = false;
                                                    }
                                                  });
                                                  return Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: Checkbox(
                                                        value: isBonusCheck,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            userProvider.checkRaidBonusCheck(
                                                                characterIndex, index, difficulty, phaseIndex, value!);
                                                          });
                                                        }),
                                                  );
                                                } else {
                                                  List<CheckHistory?> list = userProvider.charactersProvider
                                                      .characters[characterIndex].raidContents[index].bonusList;
                                                  if (list[phaseIndex - 1]!.check &&
                                                      list[phaseIndex - 1]!.difficulty == difficulty) {
                                                    isBonusCheck = true;
                                                  }
                                                  return Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: Checkbox(
                                                        value: isBonusCheck,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            userProvider.checkRaidBonusCheck(
                                                                characterIndex, index, difficulty, phaseIndex, value!);
                                                          });
                                                        }),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ));
                          } else {
                            list.add(Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${raidContents[index].difficulty[difficultyIndex]}',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                        color: difficultyText(raidContents[index].difficulty[difficultyIndex]),
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // 클리어 열
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('클리어'),
                                          Container(
                                            width: 60,
                                            height: 50 * (raidContents[index].totalPhase + 1),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: raidContents[index].totalPhase + 1,
                                              itemBuilder: (context, phaseIndex) {
                                                if (phaseIndex == 0) {
                                                  bool isTotalCheck = true;
                                                  userProvider
                                                      .charactersProvider.characters[characterIndex].raidContents[index].clearList
                                                      .forEach((element) {
                                                    if (!(element.check) || element.difficulty != difficulty) {
                                                      isTotalCheck = false;
                                                    }
                                                  });
                                                  return Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: Checkbox(
                                                        value: isTotalCheck,
                                                        onChanged: (value) => setState(() {
                                                              userProvider.checkRaidClearCheck(
                                                                  characterIndex, index, difficulty, phaseIndex, value!);
                                                            })),
                                                  );
                                                } else {
                                                  bool isChecked = false;
                                                  List<CheckHistory?> list = userProvider.charactersProvider
                                                      .characters[characterIndex].raidContents[index].clearList;
                                                  if (list[phaseIndex - 1]!.check &&
                                                      list[phaseIndex - 1]!.difficulty == difficulty) {
                                                    isChecked = true;
                                                  }
                                                  return Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: Checkbox(
                                                        value: isChecked,
                                                        onChanged: (value) => setState(() {
                                                              userProvider.checkRaidClearCheck(
                                                                  characterIndex, index, difficulty, phaseIndex, value!);
                                                            })),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // 더보기 열
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('더보기'),
                                          Container(
                                            width: 60,
                                            height: 50 * (raidContents[index].totalPhase + 1),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: raidContents[index].totalPhase + 1,
                                              itemBuilder: (context, phaseIndex) {
                                                bool isBonusCheck = false;
                                                if (phaseIndex == 0) {
                                                  bool isBonusCheck = true;
                                                  userProvider
                                                      .charactersProvider.characters[characterIndex].raidContents[index].bonusList
                                                      .forEach((element) {
                                                    if (!(element.check) || element.difficulty != difficulty) {
                                                      isBonusCheck = false;
                                                    }
                                                  });
                                                  return Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: Checkbox(
                                                      value: isBonusCheck,
                                                      // void checkRaidBonusCheck(int characterIndex, int contentIndex, String difficulty, int phaseIndex, bool value)
                                                      onChanged: (value) => setState(() {
                                                        userProvider.checkRaidBonusCheck(
                                                            characterIndex, index, difficulty, phaseIndex, value!);
                                                      }),
                                                    ),
                                                  );
                                                } else {
                                                  List<CheckHistory?> list = userProvider.charactersProvider
                                                      .characters[characterIndex].raidContents[index].bonusList;
                                                  if (list[phaseIndex - 1]!.check &&
                                                      list[phaseIndex - 1]!.difficulty == difficulty) {
                                                    isBonusCheck = true;
                                                  }
                                                  return Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: Checkbox(
                                                      value: isBonusCheck,
                                                      onChanged: (value) => setState(() {
                                                        userProvider.checkRaidBonusCheck(
                                                            characterIndex, index, difficulty, phaseIndex, value!);
                                                      }),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ));
                          }
                        }
                        return AlertDialog(
                          scrollable: true,
                          title: Text('${raidContents[index].name}', style: Theme.of(context).textTheme.headline1),
                          contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: list,
                              )
                            ],
                          ),
                        );
                      });
                    });
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<void> addGoldAlertDialog(BuildContext context, int index) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    Character character = userProvider.charactersProvider.characters[widget.characterIndex];
    List<RaidContent> raidContents = character.raidContents;
    showPlatformDialog(
      context: context,
      builder: (BuildContext context) {
        addGoldTextEditingController.text = raidContents[index].addGold.toString();
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return PlatformAlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: ListTile(
                          title: const Text('일반'),
                          horizontalTitleGap: 0,
                          leading: Radio<AddGoldType>(
                            value: AddGoldType.normal,
                            groupValue: _goldType,
                            onChanged: (AddGoldType? value) {
                              setState(() {
                                _goldType = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: const Text('버스'),
                          horizontalTitleGap: 0,
                          leading: Radio<AddGoldType>(
                            value: AddGoldType.bus,
                            groupValue: _goldType,
                            onChanged: (AddGoldType? value) {
                              setState(() {
                                _goldType = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  _goldType.name == "normal"
                      ? TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: addGoldTextEditingController,
                          decoration: InputDecoration(
                            hintText: '수입 골드',
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                      : TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: addGoldTextEditingController,
                          decoration: InputDecoration(
                            hintText: '지출 골드',
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    int add = int.parse(addGoldTextEditingController.text);
                    int minus = int.parse(minusGoldTextEditingController.text);
                    userProvider.updateAddGold(widget.characterIndex, index, add, minus);
                    FocusScope.of(context).unfocus(); // 키보드 해제
                    Navigator.pop(context);
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  bool totalClearCheck(RaidContent raidContent) {
    for (int i = 0; i < raidContent.clearCheckStandardPhase; i++) {
      if (raidContent.clearList[i].check == false) {
        return false;
      }
    }
    return true;
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

  Color difficultyText(String name) {
    if (name.contains('노말')) {
      return Colors.green;
    }
    if (name.contains('하드')) {
      return Colors.red;
    }
    return Colors.white;
  }

  int clearGoldIndex(RaidContent raidContent, String nickName) {
    int clearGold = 0;
    int bonusGold = 0;
    for (int i = 0; i < raidContent.clearList.length; i++) {
      if (raidContent.clearList[i].check) {
        if (expeditionBox.get('expeditionList')!.possibleGoldCharacters.contains(nickName)) {
          clearGold += int.parse(raidContent.reward[raidContent.clearList[i].difficulty]!['클리어골드'][i].toString());
        }
        if (raidContent.bonusList[i].check) {
          bonusGold += int.parse(raidContent.reward[raidContent.bonusList[i].difficulty]!['더보기골드'][i].toString());
        }
      }
    }
    clearGold += (raidContent.addGold - raidContent.minusGold);
    return clearGold - bonusGold;
  }
}

enum AddGoldType { normal, bus }
