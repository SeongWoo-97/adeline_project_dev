import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/dark_mode/dark_theme_provider.dart';

import '../controller/add_character_provider.dart';

class RaidContentListWidget extends StatefulWidget {
  @override
  State<RaidContentListWidget> createState() => _RaidContentListWidgetState();
}

class _RaidContentListWidgetState extends State<RaidContentListWidget> {
  @override
  Widget build(BuildContext context) {
    AddCharacterProvider addCharacterProvider = Provider.of<AddCharacterProvider>(context);

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: addCharacterProvider.raidContents.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
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
                            child: iconPerType(addCharacterProvider.raidContents[index].type),
                          ),
                          Text(
                            '${addCharacterProvider.raidContents[index].name}',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                          ),
                          difficultyText(addCharacterProvider.raidContents[index].difficulty.toString()),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          value: addCharacterProvider.raidContents[index].isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              addCharacterProvider.raidContents[index].isChecked = value!;
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
