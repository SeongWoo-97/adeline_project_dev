import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../constant/constant.dart';
import '../../../../../../model/dark_mode/dark_theme_provider.dart';
import '../../../../../../model/user/character/character_model.dart';
import '../../../../../../model/user/content/raid_content.dart';
import '../../../../../../model/user/user_provider.dart';

class RaidContentsWidget extends StatefulWidget {
  final int characterIndex;

  const RaidContentsWidget(this.characterIndex);

  @override
  State<RaidContentsWidget> createState() => _raidContentsWidgetState();
}

class _raidContentsWidgetState extends State<RaidContentsWidget> {
  AddGoldType _goldType = AddGoldType.normal;
  int busCost = 0;
  TextEditingController addGoldTextEditingController = TextEditingController();
  TextEditingController numberOfPersonTextEditingController = TextEditingController();
  TextEditingController busCostTextEditingController = TextEditingController();
  List<RaidContent> defaultRaidContents = List.generate(constRaidContents.length, (index) => RaidContent.clone(constRaidContents[index]));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int characterIndex = widget.characterIndex;
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
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  child: Text('저장', style: Theme.of(context).textTheme.bodyText2),
                  onPressed: () => userProvider.setRaidContents(context, characterIndex, defaultRaidContents),
                ),
              )
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.7,
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
                            padding: const EdgeInsets.only(left: 5,top: 5),
                            child: iconPerType(defaultRaidContents[index].type),
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                '${defaultRaidContents[index].name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(color: difficultyText(defaultRaidContents[index].name), overflow: TextOverflow.ellipsis),
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
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: Card(
              child: ListTileTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ExpansionTile(
                    // todo title widget 으로 분할
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                iconPerType(raidContents[index].type),
                                SizedBox(width: 5),
                                Text('${raidContents[index].name}', style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 1.25)),
                              ],
                            ),
                            Text(
                              'Gold ${NumberFormat('###,###,###,###').format(clearGoldIndex(raidContents[index]))} G',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Row(
                            children: [
                              Text("추가 골드 : ${NumberFormat('###,###,###,###').format(raidContents[index].addGold)} G",
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15)),
                              SizedBox(width: 3),
                              InkWell(
                                child: Icon(
                                  Icons.add,
                                  color: DarkMode.isDarkMode.value ? Colors.indigoAccent : Colors.indigoAccent,
                                  size: 23,
                                ),
                                onTap: () => addGoldAlertDialog(context, index),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 50 * (raidContents[index].totalPhase.toDouble() + 2.0),
                        padding: const EdgeInsets.only(left: 10),
                        // 난이도 종류 수 만큼 생성 [노말,하드] 카양겔 같은 경우 [노말,하드1,2,3]
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: raidContents[index].difficulty.length,
                          itemBuilder: (context, difficultyIndex) {
                            // 첫번째 인스턴스는 왼쪽 구분행을 포함하여 반환 (구분행 - 전체, 1관문, 2관문 같은 것)
                            String difficulty = raidContents[index].difficulty[difficultyIndex];
                            if (difficultyIndex == 0) {
                              return Column(
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
                                              width: 82,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: raidContents[index].totalPhase + 1,
                                                itemBuilder: (context, phaseIndex) {
                                                  // 클리어 전체 버튼
                                                  if (phaseIndex == 0) {
                                                    bool isTotalCheck = true;
                                                    userProvider.charactersProvider.characters[characterIndex].raidContents[index].clearList
                                                        .forEach((element) {
                                                      if (!(element.check) || element.difficulty != difficulty) {
                                                        isTotalCheck = false;
                                                      }
                                                    });
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text('전체'),
                                                        Checkbox(
                                                            value: isTotalCheck,
                                                            onChanged: (value) => userProvider.checkRaidClearCheck(
                                                                characterIndex, index, difficulty, phaseIndex, value!)),
                                                      ],
                                                    );
                                                  } else {
                                                    bool isChecked = false;
                                                    List<CheckHistory?> list = userProvider
                                                        .charactersProvider.characters[characterIndex].raidContents[index].clearList;
                                                    if (list[phaseIndex - 1]!.check && list[phaseIndex - 1]!.difficulty == difficulty) {
                                                      isChecked = true;
                                                    }
                                                    return Row(
                                                      children: [
                                                        Text('${phaseIndex}관문'),
                                                        Checkbox(
                                                            value: isChecked,
                                                            onChanged: (value) => userProvider.checkRaidClearCheck(
                                                                characterIndex, index, difficulty, phaseIndex, value!)),
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
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: raidContents[index].totalPhase + 1,
                                                itemBuilder: (context, phaseIndex) {
                                                  // 더보기 전체 버튼
                                                  bool isBonusCheck = false;
                                                  if (phaseIndex == 0) {
                                                    bool isBonusCheck = true;
                                                    userProvider.charactersProvider.characters[characterIndex].raidContents[index].bonusList
                                                        .forEach((element) {
                                                      if (!(element.check) || element.difficulty != difficulty) {
                                                        isBonusCheck = false;
                                                      }
                                                    });
                                                    return Checkbox(
                                                        value: isBonusCheck,
                                                        onChanged: (value) => userProvider.checkRaidBonusCheck(
                                                            characterIndex, index, difficulty, phaseIndex, value!));
                                                  } else {
                                                    List<CheckHistory?> list = userProvider
                                                        .charactersProvider.characters[characterIndex].raidContents[index].bonusList;
                                                    if (list[phaseIndex - 1]!.check && list[phaseIndex - 1]!.difficulty == difficulty) {
                                                      isBonusCheck = true;
                                                    }
                                                    return Checkbox(
                                                        value: isBonusCheck,
                                                        onChanged: (value) => userProvider.checkRaidBonusCheck(
                                                            characterIndex, index, difficulty, phaseIndex, value!));
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
                              );
                            } else {
                              return Column(
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
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: raidContents[index].totalPhase + 1,
                                                itemBuilder: (context, phaseIndex) {
                                                  if (phaseIndex == 0) {
                                                    bool isTotalCheck = true;
                                                    userProvider.charactersProvider.characters[characterIndex].raidContents[index].clearList
                                                        .forEach((element) {
                                                      if (!(element.check) || element.difficulty != difficulty) {
                                                        isTotalCheck = false;
                                                      }
                                                    });
                                                    return Checkbox(
                                                        value: isTotalCheck,
                                                        onChanged: (value) => userProvider.checkRaidClearCheck(
                                                            characterIndex, index, difficulty, phaseIndex, value!));
                                                  } else {
                                                    bool isChecked = false;
                                                    List<CheckHistory?> list = userProvider
                                                        .charactersProvider.characters[characterIndex].raidContents[index].clearList;
                                                    if (list[phaseIndex - 1]!.check && list[phaseIndex - 1]!.difficulty == difficulty) {
                                                      isChecked = true;
                                                    }
                                                    return Checkbox(
                                                        value: isChecked,
                                                        onChanged: (value) => userProvider.checkRaidClearCheck(
                                                            characterIndex, index, difficulty, phaseIndex, value!));
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
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: raidContents[index].totalPhase + 1,
                                                itemBuilder: (context, phaseIndex) {
                                                  bool isBonusCheck = false;
                                                  if (phaseIndex == 0) {
                                                    bool isBonusCheck = true;
                                                    userProvider.charactersProvider.characters[characterIndex].raidContents[index].bonusList
                                                        .forEach((element) {
                                                      if (!(element.check) || element.difficulty != difficulty) {
                                                        isBonusCheck = false;
                                                      }
                                                    });
                                                    return Checkbox(
                                                      value: isBonusCheck,
                                                      // void checkRaidBonusCheck(int characterIndex, int contentIndex, String difficulty, int phaseIndex, bool value)
                                                      onChanged: (value) => userProvider.checkRaidBonusCheck(
                                                          characterIndex, index, difficulty, phaseIndex, value!),
                                                    );
                                                  } else {
                                                    List<CheckHistory?> list = userProvider
                                                        .charactersProvider.characters[characterIndex].raidContents[index].bonusList;
                                                    if (list[phaseIndex - 1]!.check && list[phaseIndex - 1]!.difficulty == difficulty) {
                                                      isBonusCheck = true;
                                                    }
                                                    return Checkbox(
                                                      value: isBonusCheck,
                                                      onChanged: (value) => userProvider.checkRaidBonusCheck(
                                                          characterIndex, index, difficulty, phaseIndex, value!),
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
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
        busCost = 0;
        busCostTextEditingController.clear();
        numberOfPersonTextEditingController.clear();
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
                            hintText: '골드 입력',
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
                      : Column(
                          children: [
                            Text('손님 수'),
                            Row(
                              children: [
                                Flexible(
                                  child: ElevatedButton(
                                    child: Text(
                                      '1명',
                                      style: TextStyle(color: DarkMode.isDarkMode.value ? Colors.white : Colors.black),
                                    ),
                                    onPressed: () {
                                      numberOfPersonTextEditingController.text = "1";
                                      if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                          busCostTextEditingController.text.isNotEmpty) {
                                        setState(() {
                                          int numberOfPerson = int.parse(numberOfPersonTextEditingController.text);
                                          int Cost = int.parse(busCostTextEditingController.text);
                                          busCost = numberOfPerson * Cost;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Flexible(
                                  child: ElevatedButton(
                                    child: Text(
                                      '2명',
                                      style: TextStyle(color: DarkMode.isDarkMode.value ? Colors.white : Colors.black),
                                    ),
                                    onPressed: () {
                                      numberOfPersonTextEditingController.text = "2";
                                      if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                          busCostTextEditingController.text.isNotEmpty) {
                                        setState(() {
                                          int numberOfPerson = int.parse(numberOfPersonTextEditingController.text);
                                          int Cost = int.parse(busCostTextEditingController.text);
                                          busCost = numberOfPerson * Cost;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Flexible(
                                  child: ElevatedButton(
                                    child: Text(
                                      '3명',
                                      style: TextStyle(color: DarkMode.isDarkMode.value ? Colors.white : Colors.black),
                                    ),
                                    onPressed: () {
                                      numberOfPersonTextEditingController.text = "3";
                                      if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                          busCostTextEditingController.text.isNotEmpty) {
                                        setState(() {
                                          int numberOfPerson = int.parse(numberOfPersonTextEditingController.text);
                                          int Cost = int.parse(busCostTextEditingController.text);
                                          busCost = numberOfPerson * Cost;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Flexible(
                                  child: ElevatedButton(
                                    child: Text(
                                      '7명',
                                      style: TextStyle(color: DarkMode.isDarkMode.value ? Colors.white : Colors.black),
                                    ),
                                    onPressed: () {
                                      numberOfPersonTextEditingController.text = "7";
                                      setState(() {
                                        if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                            busCostTextEditingController.text.isNotEmpty) {
                                          setState(() {
                                            int numberOfPerson = int.parse(numberOfPersonTextEditingController.text);
                                            int Cost = int.parse(busCostTextEditingController.text);
                                            busCost = numberOfPerson * Cost;
                                          });
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: SizedBox(
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      controller: numberOfPersonTextEditingController,
                                      decoration: InputDecoration(
                                        hintText: '인원',
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
                                      onChanged: (value) {
                                        if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                            busCostTextEditingController.text.isNotEmpty) {
                                          setState(() {
                                            int numberOfPerson = int.parse(numberOfPersonTextEditingController.text);
                                            int Cost = int.parse(busCostTextEditingController.text);
                                            busCost = numberOfPerson * Cost;
                                          });
                                        }
                                      },
                                    ),
                                    height: 30,
                                  ),
                                ),
                                Text(' * '),
                                Flexible(
                                  child: SizedBox(
                                    height: 30,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      controller: busCostTextEditingController,
                                      decoration: InputDecoration(
                                        hintText: '버스비',
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
                                      onChanged: (value) {
                                        if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                            busCostTextEditingController.text.isNotEmpty) {
                                          setState(() {
                                            int numberOfPerson = int.parse(numberOfPersonTextEditingController.text);
                                            int Cost = int.parse(busCostTextEditingController.text);
                                            busCost = numberOfPerson * Cost;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text('합계 : $busCost G'),
                            )
                          ],
                        ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_goldType == AddGoldType.normal) {
                      userProvider.updateAddGold(widget.characterIndex, index, int.parse(addGoldTextEditingController.text));
                      userProvider.updateTotalGold();
                    } else {
                      if (numberOfPersonTextEditingController.text.isNotEmpty && busCostTextEditingController.text.isNotEmpty) {
                        userProvider.updateAddGold(widget.characterIndex, index, busCost);
                        userProvider.updateTotalGold();
                      }
                    }
                    FocusScope.of(context).unfocus();
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

  Color difficultyText(String name) {
    if (name.contains('노말')) {
      return DarkMode.isDarkMode.value ? Colors.green : Colors.green.shade500;
    }
    if (name.contains('하드')) {
      return DarkMode.isDarkMode.value ? Colors.red : Colors.redAccent.shade400;
    }
    return DarkMode.isDarkMode.value ? Colors.white : Colors.black;
  }

  int clearGoldIndex(RaidContent raidContent) {
    int clearGold = 0;
    int bonusGold = 0;
    for (int i = 0; i < raidContent.clearList.length; i++) {
      if (raidContent.clearList[i].check) {
        clearGold += int.parse(raidContent.reward[raidContent.clearList[i].difficulty]!['클리어골드'][i].toString());
        if (raidContent.bonusList[i].check) {
          bonusGold += int.parse(raidContent.reward[raidContent.bonusList[i].difficulty]!['더보기골드'][i].toString());
        }
      }
    }
    clearGold += raidContent.addGold;
    return clearGold - bonusGold;
  }
}

enum AddGoldType { normal, bus }
