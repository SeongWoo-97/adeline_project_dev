import 'package:adeline_project_dev/constant/constant.dart';
import 'package:adeline_project_dev/screen/mobile/character_manual_add_screen/controller/add_character_provider.dart';
import 'package:adeline_project_dev/screen/mobile/character_manual_add_screen/widget/daily_content_list.dart';
import 'package:adeline_project_dev/screen/mobile/character_manual_add_screen/widget/gold_content_list.dart';
import 'package:adeline_project_dev/screen/mobile/character_manual_add_screen/widget/weekly_content_list.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../model/dark_mode/dark_theme_provider.dart';

class CharacterManualAddScreen extends StatefulWidget {
  const CharacterManualAddScreen({Key? key}) : super(key: key);

  @override
  State<CharacterManualAddScreen> createState() => _CharacterManualAddScreenState();
}

class _CharacterManualAddScreenState extends State<CharacterManualAddScreen> {
  AddCharacterProvider addCharacterProvider = AddCharacterProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => addCharacterProvider,
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('캐릭터 수동 추가'),
          trailingActions: [
            TextButton(
              onPressed: () {
                addCharacterProvider.addCharacter(context);
              },
              child: Text('저장', style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 5,),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,5,6,5),
                    child: DropdownSearch<String>(
                      validator: (v) => v== null ? "required field" : null,
                      dropdownSearchDecoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 45),
                        label: Text('서버 선택'),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      mode: Mode.DIALOG,
                      selectedItem: '',
                      showSelectedItems: true,
                      items: serverList,
                      dropdownSearchTextAlign: TextAlign.center,
                      onChanged: (value) {
                        addCharacterProvider.server = value!;
                        print(addCharacterProvider.server);
                      },
                      emptyBuilder: (context, searchEntry) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "서버를 선택해 주세요.",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      positionCallback: (popupButtonObject, overlay) {
                        final decorationBox = _findBorderBox(popupButtonObject);

                        double translateOffset = 0;
                        if (decorationBox != null) {
                          translateOffset = decorationBox.size.height - popupButtonObject.size.height;
                        }

                        final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                        return RelativeRect.fromSize(
                          Rect.fromPoints(
                            popupButtonObject
                                .localToGlobal(popupButtonObject.size.bottomLeft(Offset.zero), ancestor: overlay)
                                .translate(0, translateOffset),
                            popupButtonObject.localToGlobal(popupButtonObject.size.bottomRight(Offset.zero),
                                ancestor: overlay),
                          ),
                          Size(overlay.size.width, overlay.size.height),
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6,5,8,5),
                    child: DropdownSearch<String>(
                      validator: (v) => v== null ? "required field" : null,
                      dropdownSearchDecoration: InputDecoration(
                        label: Text('직업 선택'),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      mode: Mode.DIALOG,
                      selectedItem: '',
                      showSelectedItems: true,
                      items: jobList,
                      onChanged: (value) {
                        addCharacterProvider.job = value!;
                        print(addCharacterProvider.job);
                      },
                      emptyBuilder: (context, searchEntry) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "직업을 선택해 주세요.",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      positionCallback: (popupButtonObject, overlay) {
                        final decorationBox = _findBorderBox(popupButtonObject);

                        double translateOffset = 0;
                        if (decorationBox != null) {
                          translateOffset = decorationBox.size.height - popupButtonObject.size.height;
                        }

                        final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                        return RelativeRect.fromSize(
                          Rect.fromPoints(
                            popupButtonObject
                                .localToGlobal(popupButtonObject.size.bottomLeft(Offset.zero), ancestor: overlay)
                                .translate(0, translateOffset),
                            popupButtonObject.localToGlobal(popupButtonObject.size.bottomRight(Offset.zero),
                                ancestor: overlay),
                          ),
                          Size(overlay.size.width, overlay.size.height),
                        );
                      },
                    ),
                  ),
                )

              ],
            ),
            Form(
              key: addCharacterProvider.formKey1,
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
                            controller: addCharacterProvider.nickNameController,
                            decoration: InputDecoration(
                              hintText: '닉네임',
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: addCharacterProvider.nickNameError ? Colors.red : Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: addCharacterProvider.nickNameError ? Colors.red : Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty || value.length > 12) {
                                  addCharacterProvider.nickNameError = true;
                                } else {
                                  addCharacterProvider.nickNameError = false;
                                }
                              });
                              // print(addCharacterProvider.nickNameError);
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
                            controller: addCharacterProvider.levelController,
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.done,
                            material: (_, __) => MaterialTextFormFieldData(
                              decoration: InputDecoration(),
                            ),
                            cupertino: (_, __) => CupertinoTextFormFieldData(
                              textInputAction: TextInputAction.done,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: BoxDecoration(
                                border: Border.all(color: addCharacterProvider.levelError ? Colors.red : Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              maxLength: 12,
                              keyboardType: TextInputType.number,
                            ),
                            hintText: '아이템 레벨',
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty || value.length > 4) {
                                  addCharacterProvider.levelError = true;
                                } else {
                                  addCharacterProvider.levelError = false;
                                }
                              });
                            },
                            onSaved: (value) {},
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
                              controller: addCharacterProvider.levelController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: '아이템 레벨',
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: addCharacterProvider.levelError ? Colors.red : Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: addCharacterProvider.levelError ? Colors.red : Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty || value.length > 4) {
                                    addCharacterProvider.levelError = true;
                                  } else {
                                    addCharacterProvider.levelError = false;
                                  }
                                });
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
            Form(
              key: addCharacterProvider.formKey2,
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
                                            controller: addCharacterProvider.chaosGaugeController,
                                            textAlign: TextAlign.center,
                                            cupertino: (_, __) => CupertinoTextFormFieldData(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: BoxDecoration(
                                                border:
                                                    Border.all(color: addCharacterProvider.chaosError ? Colors.red : Colors.grey),
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                if (value.length == 0 ||
                                                    int.parse(value.toString()) % 10 != 0 ||
                                                    int.parse(value.toString()) < 0 ||
                                                    int.parse(value.toString()) > 100) {
                                                  addCharacterProvider.chaosError = true;
                                                } else {
                                                  addCharacterProvider.chaosError = false;
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
                                                controller: addCharacterProvider.chaosGaugeController,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: addCharacterProvider.chaosError ? Colors.red : Colors.grey,
                                                        width: 0.5),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: addCharacterProvider.chaosError ? Colors.red : Colors.grey,
                                                        width: 0.5),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.length == 0 ||
                                                        int.parse(value.toString()) % 10 != 0 ||
                                                        int.parse(value.toString()) < 0 ||
                                                        int.parse(value.toString()) > 100) {
                                                      addCharacterProvider.chaosError = true;
                                                    } else {
                                                      addCharacterProvider.chaosError = false;
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
                                          setState(() {
                                            if (addCharacterProvider.dailyContents[0].clearNum > 0) {
                                              addCharacterProvider.dailyContents[0].clearNum -= 1;
                                            } else {
                                              toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        '${addCharacterProvider.dailyContents[0].clearNum}',
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                          'assets/etc/math_plus.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        onTap: () {
                                          if (addCharacterProvider.dailyContents[0].clearNum <
                                              addCharacterProvider.dailyContents[0].maxClearNum) {
                                            addCharacterProvider.dailyContents[0].clearNum += 1;
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
                                            controller: addCharacterProvider.guardianGaugeController,
                                            textAlign: TextAlign.center,
                                            cupertino: (_, __) => CupertinoTextFormFieldData(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: addCharacterProvider.guardianError ? Colors.red : Colors.grey),
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                if (value.length == 0 ||
                                                    int.parse(value.toString()) % 10 != 0 ||
                                                    int.parse(value.toString()) < 0 ||
                                                    int.parse(value.toString()) > 100) {
                                                  addCharacterProvider.guardianError = true;
                                                } else {
                                                  addCharacterProvider.guardianError = false;
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
                                                controller: addCharacterProvider.guardianGaugeController,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: addCharacterProvider.guardianError ? Colors.red : Colors.grey,
                                                        width: 0.5),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: addCharacterProvider.guardianError ? Colors.red : Colors.grey,
                                                        width: 0.5),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                onSaved: (value) {},
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.length == 0 ||
                                                        int.parse(value.toString()) % 10 != 0 ||
                                                        int.parse(value.toString()) < 0 ||
                                                        int.parse(value.toString()) > 100) {
                                                      addCharacterProvider.guardianError = true;
                                                    } else {
                                                      addCharacterProvider.guardianError = false;
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
                                          setState(() {
                                            if (addCharacterProvider.dailyContents[1].clearNum > 0) {
                                              addCharacterProvider.dailyContents[1].clearNum -= 1;
                                            } else {
                                              toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        '${addCharacterProvider.dailyContents[1].clearNum}',
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                          'assets/etc/math_plus.png',
                                          width: 25,
                                          height: 25,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            if (addCharacterProvider.dailyContents[1].clearNum <
                                                addCharacterProvider.dailyContents[1].maxClearNum) {
                                              addCharacterProvider.dailyContents[1].clearNum += 1;
                                            } else {
                                              toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                            }
                                          });
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
                                            controller: addCharacterProvider.eponaGaugeController,
                                            textAlign: TextAlign.center,
                                            cupertino: (_, __) => CupertinoTextFormFieldData(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              decoration: BoxDecoration(
                                                border:
                                                    Border.all(color: addCharacterProvider.eponaError ? Colors.red : Colors.grey),
                                                borderRadius: BorderRadius.circular(7),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                if (value.length == 0 ||
                                                    int.parse(value.toString()) % 10 != 0 ||
                                                    int.parse(value.toString()) < 0 ||
                                                    int.parse(value.toString()) > 100) {
                                                  addCharacterProvider.eponaError = true;
                                                } else {
                                                  addCharacterProvider.eponaError = false;
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
                                                controller: addCharacterProvider.eponaGaugeController,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: addCharacterProvider.eponaError ? Colors.red : Colors.grey,
                                                        width: 0.5),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: addCharacterProvider.eponaError ? Colors.red : Colors.grey,
                                                        width: 0.5),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.length == 0 ||
                                                        int.parse(value.toString()) % 10 != 0 ||
                                                        int.parse(value.toString()) < 0 ||
                                                        int.parse(value.toString()) > 100) {
                                                      addCharacterProvider.eponaError = true;
                                                    } else {
                                                      addCharacterProvider.eponaError = false;
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
                                        child: Image.asset('assets/etc/math_minus.png', width: 25, height: 25),
                                        onTap: () {
                                          setState(() {
                                            if (addCharacterProvider.dailyContents[2].clearNum > 0) {
                                              addCharacterProvider.dailyContents[2].clearNum -= 1;
                                            } else {
                                              toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                            }
                                          });
                                        },
                                      ),
                                      Text('${addCharacterProvider.dailyContents[2].clearNum}',
                                          style: Theme.of(context).textTheme.bodyText1),
                                      InkWell(
                                        child: Image.asset('assets/etc/math_plus.png', width: 25, height: 25),
                                        onTap: () {
                                          setState(() {
                                            if (addCharacterProvider.dailyContents[2].clearNum <
                                                addCharacterProvider.dailyContents[2].maxClearNum) {
                                              addCharacterProvider.dailyContents[2].clearNum += 1;
                                            } else {
                                              toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                            }
                                          });
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
            ChipsChoice<int>.single(
              value: addCharacterProvider.tag,
              onChanged: (val) {
                setState(() {
                  addCharacterProvider.tag = val;
                });
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: addCharacterProvider.options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              choiceStyle: C2ChoiceStyle(
                showCheckmark: false,
                color: Colors.black,
                backgroundColor: themeProvider.darkTheme ? Colors.grey : Colors.white,
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
            Expanded(child: ListView(children: [widgetPerContents(addCharacterProvider.options[addCharacterProvider.tag])])),
          ],
        ),
      ),
    );
  }

  Widget widgetPerContents(String tag) {
    switch (tag) {
      case "일일 콘텐츠":
        return DailyContentListWidget();
      case "주간 콘텐츠":
        return WeeklyContentListWidget();
      case "골드 콘텐츠":
        return GoldContentListWidget();
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

  RenderBox? _findBorderBox(RenderBox box) {
    RenderBox? borderBox;

    box.visitChildren((child) {
      if (child is RenderCustomPaint) {
        borderBox = child;
      }

      final box = _findBorderBox(child as RenderBox);
      if (box != null) {
        borderBox = box;
      }
    });

    return borderBox;
  }
}
