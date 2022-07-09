import 'package:adeline_app/constant/constant.dart';
import 'package:adeline_app/model/user/content/raid_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../model/dark_mode/dark_theme_provider.dart';

import '../../../../model/user/user_provider.dart';

class GoldContentSettingWidget extends StatefulWidget {
  final int characterIndex;

  GoldContentSettingWidget(this.characterIndex);

  @override
  State<GoldContentSettingWidget> createState() => _GoldContentSettingWidgetState();
}

class _GoldContentSettingWidgetState extends State<GoldContentSettingWidget> {
  List<RaidContent> defaultRaidContents = List.generate(constRaidContents.length, (index) => RaidContent.clone(constRaidContents[index]));

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: userProvider.charactersProvider.characters[widget.characterIndex].raidContents.length,
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
                                userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index].type),
                          ),
                          Text(
                            '${userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index].name}',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                          ),
                          difficultyText(userProvider
                              .charactersProvider.characters[widget.characterIndex].raidContents[index].difficulty
                              .toString()),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          value:
                              userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index].isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              userProvider.charactersProvider.characters[widget.characterIndex].raidContents[index]
                                  .isChecked = value!;
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
