import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../constant/constant.dart';
import '../../../../../model/user/character/character_model.dart';
import '../../../../../model/user/content/gold_content.dart';
import '../../../../../model/user/user_provider.dart';

class GoldContentsWidget extends StatefulWidget {
  final int characterIndex;

  const GoldContentsWidget(this.characterIndex);

  @override
  State<GoldContentsWidget> createState() => _GoldContentsWidgetState();
}

class _GoldContentsWidgetState extends State<GoldContentsWidget> {
  AddGoldType _goldType = AddGoldType.normal;
  int busCost = 0;
  TextEditingController addGoldTextEditingController = TextEditingController();
  TextEditingController numberOfPersonTextEditingController = TextEditingController();
  TextEditingController busCostTextEditingController = TextEditingController();
  List<GoldContent> defaultGoldContents =
      List.generate(constGoldContents.length, (index) => GoldContent.clone(constGoldContents[index]));

  @override
  void initState() {
    super.initState();
    print(widget.characterIndex);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    int characterIndex = widget.characterIndex;
    if (userProvider.charactersProvider.characters[characterIndex].goldContents.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('해당 캐릭터는 골드 콘텐츠가 설정되어 있지 않습니다.'),
                  Text('원하시는 콘텐츠를 선택하신후 저장 버튼을 눌러주세요!'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      userProvider.charactersProvider.characters[characterIndex].goldContents = defaultGoldContents;
                      userProvider.updateContentBoard();
                    });
                  },
                  child: Text('저장'),
                ),
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: userProvider.charactersProvider.characters[characterIndex].goldContents.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (userProvider.charactersProvider.characters[characterIndex].goldContents[index].isChecked == true) {
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
                          child: iconPerType(userProvider.charactersProvider.characters[characterIndex].goldContents[index].type),
                        ),
                        InkWell(
                          child: Text(
                            '${userProvider.charactersProvider.characters[characterIndex].goldContents[index].name}',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                          ),
                          onLongPress: () {
                            setState(() {
                              userProvider.charactersProvider.characters[characterIndex].goldContents[index]
                                  .characterAlwaysMaxClear = false;
                              userProvider.goldContentsClearCheck(characterIndex, index, false);
                            });
                            Fluttertoast.showToast(
                                msg: "항상 최대 관문 클리어 체크가 해제되었습니다.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey,
                                fontSize: 14.0);
                          },
                        ),
                        difficultyText(
                            userProvider.charactersProvider.characters[characterIndex].goldContents[index].difficulty.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                              '${clearGoldPerCharacter(userProvider.charactersProvider.characters[characterIndex], index)}',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15)),
                        ),
                        SizedBox(
                          height: 25,
                          child: Checkbox(
                            value: userProvider.charactersProvider.characters[characterIndex].goldContents[index].clearChecked,
                            onChanged: (bool? value) {
                              if (userProvider
                                  .charactersProvider.characters[characterIndex].goldContents[index].characterAlwaysMaxClear) {
                                int totalGold = 0;
                                userProvider.charactersProvider.characters[characterIndex].goldContents[index].goldPerPhase
                                    .forEach((element) => totalGold += element);
                                userProvider.charactersProvider.characters[characterIndex].goldContents[index].clearGold =
                                    totalGold;
                                userProvider.goldContentsClearCheck(characterIndex, index, value);
                              } else {
                                showPlatformDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                        return PlatformAlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  '${userProvider.charactersProvider.characters[characterIndex].goldContents[index].name}(${userProvider.charactersProvider.characters[characterIndex].goldContents[index].difficulty})'),
                                              Container(
                                                width: 300,
                                                height: 90,
                                                child: GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    childAspectRatio: 1 / 2,
                                                    mainAxisExtent: 40,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5,
                                                  ),
                                                  itemCount: userProvider.charactersProvider.characters[characterIndex]
                                                      .goldContents[index].totalPhase,
                                                  itemBuilder: (context, gridIndex) {
                                                    return ElevatedButton(
                                                        onPressed: () {
                                                          int totalGold = 0;
                                                          for (int i = 0; i <= gridIndex; i++) {
                                                            totalGold += userProvider.charactersProvider
                                                                .characters[characterIndex].goldContents[index].goldPerPhase[i];
                                                          }
                                                          userProvider.charactersProvider.characters[characterIndex]
                                                              .goldContents[index].clearGold = totalGold;
                                                          userProvider.goldContentsClearCheck(characterIndex, index, true);
                                                          Navigator.pop(context);
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(3.0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text('${gridIndex + 1}관문'),
                                                              Text(
                                                                  '${clearGoldIndex(userProvider.charactersProvider.characters[characterIndex].goldContents[index].goldPerPhase, gridIndex)} G'),
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    value: userProvider.charactersProvider.characters[characterIndex]
                                                        .goldContents[index].characterAlwaysMaxClear,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        userProvider.charactersProvider.characters[characterIndex]
                                                            .goldContents[index].characterAlwaysMaxClear = value!;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    '이 캐릭터는 항상 최대관문 클리어 설정',
                                                    style: TextStyle(fontSize: 14),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                    });
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 5, bottom: 5, right: 2),
                                  child: Consumer<UserProvider>(
                                    builder: (context, instance, child) {
                                      return Text(
                                          "추가 골드 : ${instance.charactersProvider.characters[characterIndex].goldContents[index].addGold} G",
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14));
                                    },
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.indigoAccent,
                                      size: 20,
                                    ),
                                    onTap: () {
                                      showPlatformDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          addGoldTextEditingController.text = userProvider
                                              .charactersProvider.characters[characterIndex].goldContents[index].addGold
                                              .toString();
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
                                                                      child: Text('1명'),
                                                                      onPressed: () {
                                                                        numberOfPersonTextEditingController.text = "1";
                                                                        if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                                                            busCostTextEditingController.text.isNotEmpty) {
                                                                          setState(() {
                                                                            int numberOfPerson = int.parse(
                                                                                numberOfPersonTextEditingController.text);
                                                                            int Cost =
                                                                                int.parse(busCostTextEditingController.text);
                                                                            busCost = numberOfPerson * Cost;
                                                                          });
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: ElevatedButton(
                                                                      child: Text('2명'),
                                                                      onPressed: () {
                                                                        numberOfPersonTextEditingController.text = "2";
                                                                        if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                                                            busCostTextEditingController.text.isNotEmpty) {
                                                                          setState(() {
                                                                            int numberOfPerson = int.parse(
                                                                                numberOfPersonTextEditingController.text);
                                                                            int Cost =
                                                                                int.parse(busCostTextEditingController.text);
                                                                            busCost = numberOfPerson * Cost;
                                                                          });
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: ElevatedButton(
                                                                      child: Text('3명'),
                                                                      onPressed: () {
                                                                        numberOfPersonTextEditingController.text = "3";
                                                                        if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                                                            busCostTextEditingController.text.isNotEmpty) {
                                                                          setState(() {
                                                                            int numberOfPerson = int.parse(
                                                                                numberOfPersonTextEditingController.text);
                                                                            int Cost =
                                                                                int.parse(busCostTextEditingController.text);
                                                                            busCost = numberOfPerson * Cost;
                                                                          });
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: ElevatedButton(
                                                                      child: Text('7명'),
                                                                      onPressed: () {
                                                                        numberOfPersonTextEditingController.text = "7";
                                                                        setState(() {
                                                                          if (numberOfPersonTextEditingController
                                                                                  .text.isNotEmpty &&
                                                                              busCostTextEditingController.text.isNotEmpty) {
                                                                            setState(() {
                                                                              int numberOfPerson = int.parse(
                                                                                  numberOfPersonTextEditingController.text);
                                                                              int Cost =
                                                                                  int.parse(busCostTextEditingController.text);
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
                                                                            borderSide:
                                                                                BorderSide(color: Colors.grey, width: 0.5),
                                                                            borderRadius: BorderRadius.circular(8),
                                                                          ),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.grey, width: 0.5),
                                                                            borderRadius: BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                        onChanged: (value) {
                                                                          if (numberOfPersonTextEditingController
                                                                                  .text.isNotEmpty &&
                                                                              busCostTextEditingController.text.isNotEmpty) {
                                                                            setState(() {
                                                                              int numberOfPerson = int.parse(
                                                                                  numberOfPersonTextEditingController.text);
                                                                              int Cost =
                                                                                  int.parse(busCostTextEditingController.text);
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
                                                                            borderSide:
                                                                                BorderSide(color: Colors.grey, width: 0.5),
                                                                            borderRadius: BorderRadius.circular(8),
                                                                          ),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.grey, width: 0.5),
                                                                            borderRadius: BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                        onChanged: (value) {
                                                                          if (numberOfPersonTextEditingController
                                                                                  .text.isNotEmpty &&
                                                                              busCostTextEditingController.text.isNotEmpty) {
                                                                            setState(() {
                                                                              int numberOfPerson = int.parse(
                                                                                  numberOfPersonTextEditingController.text);
                                                                              int Cost =
                                                                                  int.parse(busCostTextEditingController.text);
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
                                                                child: Text('합계 : $busCost'),
                                                              )
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      if (_goldType == AddGoldType.normal) {
                                                        userProvider.updateAddGold(
                                                            characterIndex, index, int.parse(addGoldTextEditingController.text));
                                                      } else {
                                                        if (numberOfPersonTextEditingController.text.isNotEmpty &&
                                                            busCostTextEditingController.text.isNotEmpty) {
                                                          userProvider.updateAddGold(characterIndex, index, busCost);
                                                        }
                                                      }
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
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
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

enum AddGoldType { normal, bus }
