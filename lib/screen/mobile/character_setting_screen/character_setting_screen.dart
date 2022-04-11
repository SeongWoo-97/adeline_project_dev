import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:adeline_project_dev/screen/mobile/character_setting_screen/widget/daily_contents_settings_widget.dart';
import 'package:adeline_project_dev/screen/mobile/character_setting_screen/widget/gold_contents_settings_widget.dart';
import 'package:adeline_project_dev/screen/mobile/character_setting_screen/widget/weekly_contents_settings_widget.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../model/user/character/character_model.dart';


class CharacterSettingsScreen extends StatefulWidget {
  final int characterIndex;

  CharacterSettingsScreen(this.characterIndex);

  @override
  State<CharacterSettingsScreen> createState() => _CharacterSettingsScreenState();
}

class _CharacterSettingsScreenState extends State<CharacterSettingsScreen> {
  int tag = 0;
  String iconName = iconList[0].iconName!;

  List<String> options = ['일일 콘텐츠', '주간 콘텐츠', '골드 콘텐츠'];
  List<Card> dailyCardList = [];
  List<Card> weeklyCardList = [];

  final key = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  bool nickNameError = false;
  bool levelError = false;
  bool chaosError = false;
  bool guardianError = false;
  bool eponaError = false;

  TextEditingController nickNameController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController chaosGaugeController = TextEditingController();
  TextEditingController guardianGaugeController = TextEditingController();
  TextEditingController eponaGaugeController = TextEditingController();
  TextEditingController addController = TextEditingController();

  DragAndDropList weeklyDragAndDrop = DragAndDropList(children: []);
  DragAndDropList dailyDragAndDrop = DragAndDropList(children: []);

  late Character character;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    nickNameController.text = userProvider.charactersProvider.characters[widget.characterIndex].nickName;
    levelController.text = userProvider.charactersProvider.characters[widget.characterIndex].level;
    chaosGaugeController.text = userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[0].restGauge.toString();
    guardianGaugeController.text = userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[1].restGauge.toString();
    eponaGaugeController.text = userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[2].restGauge.toString();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    character = userProvider.charactersProvider.characters[widget.characterIndex];
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          '캐릭터 설정',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        material: (_, __) => MaterialAppBarData(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: .5,
          title: Text('캐릭터 정보수정', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
      cupertino: (_, __) => CupertinoPageScaffoldData(),
      material: (_, __) => MaterialScaffoldData(
        body: Column(
          children: [
            // 닉네임, 레벨 TextField
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 35,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, left: 5),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: nickNameController,
                            decoration: InputDecoration(
                              hintText: '닉네임',
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: nickNameError ? Colors.red : Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: nickNameError ? Colors.red : Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty || value.length >= 12) {
                                  nickNameError = true;
                                } else {
                                  nickNameError = false;
                                }
                              });
                            },
                            onSaved: (value) {
                              character.nickName = value!;
                            },
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: PlatformWidgetBuilder(
                        cupertino: (_, child, __) => Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: PlatformTextFormField(
                            controller: levelController,
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.done,
                            material: (_, __) => MaterialTextFormFieldData(
                              decoration: InputDecoration(),
                            ),
                            cupertino: (_, __) => CupertinoTextFormFieldData(
                              textInputAction: TextInputAction.done,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: BoxDecoration(
                                border: Border.all(color: levelError ? Colors.red : Colors.grey),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              maxLength: 12,
                              keyboardType: TextInputType.number,
                            ),
                            hintText: '아이템 레벨',
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty || value.length >= 5) {
                                  levelError = true;
                                } else {
                                  levelError = false;
                                }
                              });
                            },
                            onSaved: (value) {
                              character.level = int.parse(value.toString()).toString();
                            },
                          ),
                        ),
                        material: (_, child, __) => ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 35,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: levelController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: '아이템 레벨',
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: levelError ? Colors.red : Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: levelError ? Colors.red : Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty || value.length >= 5) {
                                    levelError = true;
                                  } else {
                                    levelError = false;
                                  }
                                });
                              },
                              onSaved: (value) {
                                character.level = int.parse(value.toString()).toString();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 휴식게이지 TextField
            Form(
              key: formKey2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 5),
                      child: Text(
                        '휴식게이지',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      child: Image.asset('assets/daily/Chaos.png', width: 25, height: 25),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                        child: PlatformWidgetBuilder(
                                          cupertino: (_, child, __) => PlatformTextFormField(
                                            controller: chaosGaugeController,
                                            textAlign: TextAlign.center,
                                            cupertino: (_, __) => CupertinoTextFormFieldData(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: BoxDecoration(
                                                border: Border.all(color: chaosError ? Colors.red : Colors.grey),
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                                            ),
                                            onSaved: (value) {
                                              character.dailyContents[0].restGauge = int.parse(value.toString());
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                if (value.length == 0 ||
                                                    int.parse(value.toString()) % 10 != 0 ||
                                                    int.parse(value.toString()) < 0 ||
                                                    int.parse(value.toString()) > 100) {
                                                  chaosError = true;
                                                } else {
                                                  chaosError = false;
                                                }
                                              });
                                            },
                                          ),
                                          material: (_, child, __) => ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: 45,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                                              child: TextFormField(
                                                controller: chaosGaugeController,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: chaosError ? Colors.red : Colors.grey, width: 0.5),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: chaosError ? Colors.red : Colors.grey, width: 0.5),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                ),
                                                onSaved: (value) {
                                                  character.dailyContents[0].restGauge = int.parse(value.toString());
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.length == 0 ||
                                                        int.parse(value.toString()) % 10 != 0 ||
                                                        int.parse(value.toString()) < 0 ||
                                                        int.parse(value.toString()) > 100) {
                                                      chaosError = true;
                                                    } else {
                                                      chaosError = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '클리어 횟수',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        child: Image.asset(
                                          'assets/etc/math_minus.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        onTap: () {
                                          if (character.dailyContents[0].clearNum > 0) {
                                            character.dailyContents[0].clearNum -= 1;
                                            setState(() {});
                                          } else {
                                            toast('최소 클리어 횟수는 0입니다.');
                                          }
                                        },
                                      ),
                                      Text(
                                        '${character.dailyContents[0].clearNum}',
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                          'assets/etc/math_plus.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        onTap: () {
                                          if (character.dailyContents[0].clearNum <
                                              character.dailyContents[0].maxClearNum) {
                                            character.dailyContents[0].clearNum += 1;
                                            setState(() {});
                                          } else {
                                            toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      child: Image.asset('assets/daily/Guardian.png', width: 25, height: 25),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                        child: PlatformWidgetBuilder(
                                          cupertino: (_, child, __) => PlatformTextFormField(
                                            controller: guardianGaugeController,
                                            textAlign: TextAlign.center,
                                            cupertino: (_, __) => CupertinoTextFormFieldData(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: BoxDecoration(
                                                border: Border.all(color: guardianError ? Colors.red : Colors.grey),
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                                            ),
                                            onSaved: (value) {
                                              character.dailyContents[1].restGauge = int.parse(value.toString());
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                if (value.length == 0 ||
                                                    int.parse(value.toString()) % 10 != 0 ||
                                                    int.parse(value.toString()) < 0 ||
                                                    int.parse(value.toString()) > 100) {
                                                  guardianError = true;
                                                } else {
                                                  guardianError = false;
                                                }
                                              });
                                            },
                                          ),
                                          material: (_, child, __) => ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: 45,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                                              child: TextFormField(
                                                controller: guardianGaugeController,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: guardianError ? Colors.red : Colors.grey, width: 0.5),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: guardianError ? Colors.red : Colors.grey, width: 0.5),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                ),
                                                onSaved: (value) {
                                                  character.dailyContents[1].restGauge = int.parse(value.toString());
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.length == 0 ||
                                                        int.parse(value.toString()) % 10 != 0 ||
                                                        int.parse(value.toString()) < 0 ||
                                                        int.parse(value.toString()) > 100) {
                                                      guardianError = true;
                                                    } else {
                                                      guardianError = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '클리어 횟수',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        child: Image.asset(
                                          'assets/etc/math_minus.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        onTap: () {
                                          if (character.dailyContents[1].clearNum > 0) {
                                            character.dailyContents[1].clearNum -= 1;
                                            setState(() {});
                                          } else {
                                            toast('최소 클리어 횟수는 0입니다.');
                                          }
                                        },
                                      ),
                                      Text(
                                        '${character.dailyContents[1].clearNum}',
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                          'assets/etc/math_plus.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        onTap: () {
                                          if (character.dailyContents[1].clearNum <
                                              character.dailyContents[1].maxClearNum) {
                                            character.dailyContents[1].clearNum += 1;
                                            setState(() {});
                                          } else {
                                            toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      child: Image.asset('assets/daily/Epona.png', width: 25, height: 25),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                        child: PlatformWidgetBuilder(
                                          cupertino: (_, child, __) => PlatformTextFormField(
                                            controller: eponaGaugeController,
                                            textAlign: TextAlign.center,
                                            cupertino: (_, __) => CupertinoTextFormFieldData(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: BoxDecoration(
                                                border: Border.all(color: eponaError ? Colors.red : Colors.grey),
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                                            ),
                                            onSaved: (value) {
                                              character.dailyContents[2].restGauge = int.parse(value.toString());
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                if (value.length == 0 ||
                                                    int.parse(value.toString()) % 10 != 0 ||
                                                    int.parse(value.toString()) < 0 ||
                                                    int.parse(value.toString()) > 100) {
                                                  eponaError = true;
                                                } else {
                                                  eponaError = false;
                                                }
                                              });
                                            },
                                          ),
                                          material: (_, child, __) => ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: 45,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                                              child: TextFormField(
                                                controller: eponaGaugeController,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: eponaError ? Colors.red : Colors.grey, width: 0.5),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: eponaError ? Colors.red : Colors.grey, width: 0.5),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                ),
                                                onSaved: (value) {
                                                  character.dailyContents[2].restGauge = int.parse(value.toString());
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.length == 0 ||
                                                        int.parse(value.toString()) % 10 != 0 ||
                                                        int.parse(value.toString()) < 0 ||
                                                        int.parse(value.toString()) > 100) {
                                                      eponaError = true;
                                                    } else {
                                                      eponaError = false;
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  '클리어 횟수',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        child: Image.asset(
                                          'assets/etc/math_minus.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        onTap: () {
                                          if (character.dailyContents[2].clearNum > 0) {
                                            character.dailyContents[2].clearNum -= 1;
                                            setState(() {});
                                          } else {
                                            toast('최소 클리어 횟수는 0입니다.');
                                          }
                                        },
                                      ),
                                      Text(
                                        '${character.dailyContents[2].clearNum}',
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                          'assets/etc/math_plus.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        onTap: () {
                                          if (character.dailyContents[2].clearNum <
                                              character.dailyContents[2].maxClearNum) {
                                            character.dailyContents[2].clearNum += 1;
                                            setState(() {});
                                          } else {
                                            toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // 일일,주간,골드 콘텐츠 버튼
            ChipsChoice<int>.single(
              value: tag,
              onChanged: (val) {
                setState(() {
                  tag = val;
                });
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              choiceStyle: C2ChoiceStyle(
                showCheckmark: false,
                color: Colors.grey,
                backgroundColor: Colors.white,
                borderColor: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              choiceActiveStyle: C2ChoiceStyle(
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  borderColor: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  showCheckmark: false),
            ),
            Expanded(child: ListView(children: [widgetPerContents(options[tag], widget.characterIndex)])),
          ],
        ),
      ),
    );
  }
  Widget widgetPerContents(String tag, int characterIndex) {
    switch (tag) {
      case "일일 콘텐츠":
        return DailyContentSettingWidget(characterIndex);
      case "주간 콘텐츠":
        return WeeklyContentSettingWidget(characterIndex);
      case "골드 콘텐츠":
        return GoldContentSettingWidget(characterIndex);
    }
    return Container();
  }
  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }
}
