import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widgets/gold_contents_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widgets/weekly_contents_widget.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/user/user_provider.dart';
import 'character_slot_widgets/daily_contents_widget.dart';

class CharacterSlotWidget extends StatefulWidget {
  const CharacterSlotWidget({Key? key}) : super(key: key);

  @override
  State<CharacterSlotWidget> createState() => _CharacterSlotWidgetState();
}

class _CharacterSlotWidgetState extends State<CharacterSlotWidget> {
  int tag = 0;
  List<String> options = ['일일', '주간', '골드'];
  CustomPopupMenuController _customPopupMenuController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: userProvider.charactersProvider.characters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.fromLTRB(12, 0, 10, 0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.topLeft,
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  collapsedIconColor: Colors.grey,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userProvider.charactersProvider.characters[index].nickName,
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16)),
                            Text(
                                'Lv.${userProvider.charactersProvider.characters[index].level} ${userProvider.charactersProvider.characters[index].job}',
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14)),
                            Text('주간 골드 : ${weeklyGold(index)} G',
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14)),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/daily/Chaos.png',
                                      width: 22,
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 5),
                                      child: Container(
                                        width: 30,
                                        child: Text(
                                          '0',
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/daily/Guardian.png',
                                      width: 22,
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 5),
                                      child: Container(
                                        width: 30,
                                        child: Text(
                                          '0',
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/daily/Epona.png',
                                      width: 22,
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 5),
                                      child: Container(
                                        width: 30,
                                        child: Text(
                                          '0',
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        onLongPress: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 3, 10, 5),
                                  child: Text(
                                    '일일',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                  height: 25,
                                  child: Checkbox(value: false, onChanged: (value) {}),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 3, 10, 5),
                                  child: Text(
                                    '주간',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                  height: 25,
                                  child: Checkbox(value: false, onChanged: (value) {}),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 3, 10, 5),
                                  child: Text(
                                    '골드',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                  height: 25,
                                  child: Checkbox(value: false, onChanged: (value) {}),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        IconButton(
                          icon: Icon(Icons.settings, color: Colors.grey),
                          onPressed: () {},
                        )
                      ],
                    ),
                    widgetPerContents(options[tag], index),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget widgetPerContents(String tag, int characterIndex) {
    switch (tag) {
      case "일일":
        return DailyContentsWidget(characterIndex);
      case "주간":
        return WeeklyContentsWidget(characterIndex);
      case "골드":
        return GoldContentsWidget(characterIndex);
    }
    return Container();
  }

  int weeklyGold(int characterIndex) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    int weeklyGold = 0;
    print('${userProvider.charactersProvider.characters[characterIndex].nickName}');
    userProvider.charactersProvider.characters[characterIndex].goldContents.forEach(
      (element) {
        if (element.isChecked == true && element.clearChecked == true) {
          weeklyGold += element.addGold;
          weeklyGold += element.clearGold!;
        }
      },
    );
    return weeklyGold;
  }
}
