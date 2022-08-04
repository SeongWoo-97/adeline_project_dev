import 'package:adeline_app/model/toast/toast.dart';
import 'package:adeline_app/model/user/user_provider.dart';
import 'package:adeline_app/screen/home_work/character_setting_screen/tablet_desktop/widget/not_mobile_daily_contents_settings_widget.dart';
import 'package:adeline_app/screen/home_work/character_setting_screen/tablet_desktop/widget/not_mobile_raid_contents_settings_widget.dart';
import 'package:adeline_app/screen/home_work/character_setting_screen/tablet_desktop/widget/not_mobile_weekly_contents_settings_widget.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NotMobileCharacterSettingsScreen extends StatefulWidget {
  final int characterIndex;

  NotMobileCharacterSettingsScreen(this.characterIndex);

  @override
  State<NotMobileCharacterSettingsScreen> createState() => _NotMobileCharacterSettingsScreenState();
}

class _NotMobileCharacterSettingsScreenState extends State<NotMobileCharacterSettingsScreen> {
  int tag = 0;

  List<String> options = ['일일 콘텐츠', '주간 콘텐츠', '레이드 콘텐츠'];

  final formKey1 = GlobalKey<FormState>();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('캐릭터 설정'),
        actions: [
          TextButton(
            child: Text('저장', style: Theme.of(context).textTheme.bodyText2),
            onPressed: () async {
              if (nickNameError == true) {
                ToastMessage.toast('닉네임이 잘못 설정되었습니다.');
                await Future.delayed(Duration(seconds: 1, milliseconds: 500));
              }
              if (levelError == true) {
                ToastMessage.toast('아이템 레벨 값이 잘못 설정되었습니다.');
                await Future.delayed(Duration(seconds: 1, milliseconds: 500));
              }
              if (chaosError == true || guardianError == true || eponaError == true) {
                ToastMessage.toast('휴식 게이지 값이 잘못되었습니다.');
                await Future.delayed(Duration(seconds: 1, milliseconds: 500));
              }
              if (nickNameError == false && levelError == false && chaosError == false && guardianError == false && eponaError == false) {
                formKey1.currentState?.save();
                formKey2.currentState?.save();
                userProvider.notifyListeners();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          // 닉네임, 레벨 TextField
          Form(
            key: formKey1,
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
                              if (value.isEmpty || value.length > 12) {
                                nickNameError = true;
                              } else {
                                nickNameError = false;
                              }
                            });
                          },
                          onSaved: (value) {
                            userProvider.charactersProvider.characters[widget.characterIndex].nickName = value!;
                          },
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ConstrainedBox(
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
                            userProvider.charactersProvider.characters[widget.characterIndex].level =
                                int.parse(value.toString()).toString();
                          },
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
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Image.asset('assets/daily/0.png', width: 25, height: 25),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: ConstrainedBox(
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
                                                borderSide: BorderSide(color: chaosError ? Colors.red : Colors.grey, width: 0.5),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: chaosError ? Colors.red : Colors.grey, width: 0.5),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                            onSaved: (value) {
                                              userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[0]
                                                  .restGauge = int.parse(value.toString());
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
                                        if (userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[0].clearNum >
                                            0) {
                                          userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[0].clearNum -=
                                          1;
                                          setState(() {});
                                        } else {
                                          ToastMessage.toast('최소 클리어 횟수는 0입니다.');
                                        }
                                      },
                                    ),
                                    Text(
                                      '${userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[0].clearNum}',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    InkWell(
                                      child: Image.asset(
                                        'assets/etc/math_plus.png',
                                        width: 25,
                                        height: 25,
                                      ),
                                      onTap: () {
                                        if (userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[0].clearNum <
                                            userProvider
                                                .charactersProvider.characters[widget.characterIndex].dailyContents[0].maxClearNum) {
                                          userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[0].clearNum +=
                                          1;
                                          setState(() {});
                                        } else {
                                          ToastMessage.toast('최대 클리어 횟수를 초과할 수 없습니다.');
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
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Image.asset('assets/daily/1.png', width: 25, height: 25),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: ConstrainedBox(
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
                                                borderSide: BorderSide(color: guardianError ? Colors.red : Colors.grey, width: 0.5),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: guardianError ? Colors.red : Colors.grey, width: 0.5),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                            onSaved: (value) {
                                              userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[1]
                                                  .restGauge = int.parse(value.toString());
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
                                        if (userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[1].clearNum >
                                            0) {
                                          userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[1].clearNum -=
                                          1;
                                          setState(() {});
                                        } else {
                                          ToastMessage.toast('최소 클리어 횟수는 0입니다.');
                                        }
                                      },
                                    ),
                                    Text(
                                      '${userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[1].clearNum}',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    InkWell(
                                      child: Image.asset(
                                        'assets/etc/math_plus.png',
                                        width: 25,
                                        height: 25,
                                      ),
                                      onTap: () {
                                        if (userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[1].clearNum <
                                            userProvider
                                                .charactersProvider.characters[widget.characterIndex].dailyContents[1].maxClearNum) {
                                          userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[1].clearNum +=
                                          1;
                                          setState(() {});
                                        } else {
                                          ToastMessage.toast('최대 클리어 횟수를 초과할 수 없습니다.');
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
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Image.asset('assets/daily/2.png', width: 25, height: 25),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: ConstrainedBox(
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
                                                borderSide: BorderSide(color: eponaError ? Colors.red : Colors.grey, width: 0.5),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: eponaError ? Colors.red : Colors.grey, width: 0.5),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                            onSaved: (value) {
                                              userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[2]
                                                  .restGauge = int.parse(value.toString());
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
                                        if (userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[2].clearNum >
                                            0) {
                                          userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[2].clearNum -=
                                          1;
                                          setState(() {});
                                        } else {
                                          ToastMessage.toast('최소 클리어 횟수는 0입니다.');
                                        }
                                      },
                                    ),
                                    Text(
                                      '${userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[2].clearNum}',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    InkWell(
                                      child: Image.asset(
                                        'assets/etc/math_plus.png',
                                        width: 25,
                                        height: 25,
                                      ),
                                      onTap: () {
                                        if (userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[2].clearNum <
                                            userProvider
                                                .charactersProvider.characters[widget.characterIndex].dailyContents[2].maxClearNum) {
                                          userProvider.charactersProvider.characters[widget.characterIndex].dailyContents[2].clearNum +=
                                          1;
                                          setState(() {});
                                        } else {
                                          ToastMessage.toast('최대 클리어 횟수를 초과할 수 없습니다.');
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
              color: Colors.black,
              backgroundColor: Colors.grey,
              borderColor: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            choiceActiveStyle: C2ChoiceStyle(
                color: Colors.black,
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                showCheckmark: false),
          ),
          Expanded(child: ListView(children: [widgetPerContents(options[tag], widget.characterIndex)])),
        ],
      ),
    );
  }
  Widget widgetPerContents(String tag, int characterIndex) {
    switch (tag) {
      case "일일 콘텐츠":
        return NotMobileDailyContentsSettingsWidget(characterIndex);
      case "주간 콘텐츠":
        return NotMobileWeeklyContentsSettingsWidget(characterIndex);
      case "레이드 콘텐츠":
        return NotMobileRaidContentsSettingsWidget(characterIndex);
    }
    return Container();
  }
}
