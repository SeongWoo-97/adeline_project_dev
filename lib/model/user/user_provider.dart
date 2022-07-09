import 'package:adeline_app/model/user/content/daily_content.dart';
import 'package:adeline_app/model/user/content/raid_content.dart';
import 'package:adeline_app/model/user/expedition/expedition_provider.dart';
import 'package:adeline_app/model/user/user.dart';
import 'package:adeline_app/screen/mobile/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'character/character_model.dart';
import 'character/character_provider.dart';
import 'expedition/expedition_model.dart';

class UserProvider extends ChangeNotifier {
  CharacterProvider charactersProvider;

  final characterBox = Hive.box<User>('characters');

  int totalGold = 0;

  UserProvider({required this.charactersProvider});

  @override
  void notifyListeners() {
    super.notifyListeners();
    updateTotalGold();
    print('notifyListeners : 저장완료');
    characterBox.put('user', User(characters: charactersProvider.characters));
    // todo updateTotalGold() 삭제, 원정대 콘텐츠도 작성할지 고민
  }

  // 골드 콘텐츠 추가골드
  void updateAddGold(int characterIndex, int index, int gold) {
    charactersProvider.characters[characterIndex].raidContents[index].addGold = gold;
    notifyListeners();
  }

  // 골드 콘텐츠 클리어 체크
  void goldContentsClearCheck(int characterIndex, int index, bool? value) {
    charactersProvider.characters[characterIndex].raidContents[index].clearChecked = value!;
    characterBox.put('user', User(characters: charactersProvider.characters));
    notifyListeners();
  }

  void checkRaidClearCheck(int characterIndex, int contentIndex, String difficulty, int phaseIndex, bool value) {
    List<RaidContent> raidContents = charactersProvider.characters[characterIndex].raidContents;
    if (phaseIndex == 0) {
      charactersProvider.characters[characterIndex].raidContents[contentIndex].clearList.clear();
      charactersProvider.characters[characterIndex].raidContents[contentIndex].clearList.addAll(List.generate(
          raidContents[contentIndex].totalPhase,
          (index) => CheckHistory(
                difficulty: difficulty,
                check: value,
              )));
    } else {
      charactersProvider.characters[characterIndex].raidContents[contentIndex].clearList[phaseIndex - 1] =
          CheckHistory(difficulty: difficulty, check: value);
    }
    notifyListeners();
  }

  void checkRaidBonusCheck(int characterIndex, int contentIndex, String difficulty, int phaseIndex, bool value) {
    List<RaidContent> raidContents = charactersProvider.characters[characterIndex].raidContents;
    if (phaseIndex == 0) {
      charactersProvider.characters[characterIndex].raidContents[contentIndex].bonusList.clear();
      charactersProvider.characters[characterIndex].raidContents[contentIndex].bonusList.addAll(List.generate(
          raidContents[contentIndex].totalPhase,
          (index) => CheckHistory(
                difficulty: difficulty,
                check: value,
              )));
    } else {
      charactersProvider.characters[characterIndex].raidContents[contentIndex].bonusList[phaseIndex - 1] =
          CheckHistory(difficulty: difficulty, check: value);
    }
    notifyListeners();
  }

  // 전체 획득 골드
  void updateTotalGold() {
    totalGold = 0;
  }

  // 일일 콘텐츠 클리어 체크
  void dailyContentClearCheck(int characterIndex, int index, bool? value) {
    charactersProvider.characters[characterIndex].dailyContents[index].clearChecked = value!;
    notifyListeners();
  }

  // 주간 콘텐츠 클리어 체크
  void weeklyContentClearCheck(int characterIndex, int index, bool? value) {
    charactersProvider.characters[characterIndex].weeklyContents[index].clearChecked = value!;
    characterBox.put('user', User(characters: charactersProvider.characters));
    notifyListeners();
  }

  void setRaidContents(BuildContext context, int characterIndex, List<RaidContent> raidContents) {
    charactersProvider.characters[characterIndex].raidContents = raidContents;
    notifyListeners();
  }

  // 휴식 콘텐츠 클리어 체크
  void restGaugeContentClearCheck(int characterIndex, int index) {
    if (charactersProvider.characters[characterIndex].dailyContents[index].maxClearNum !=
        charactersProvider.characters[characterIndex].dailyContents[index].clearNum) {
      charactersProvider.characters[characterIndex].dailyContents[index].clearNum += 1;
      if (charactersProvider.characters[characterIndex].dailyContents[index].restGauge >= 20) {
        charactersProvider.characters[characterIndex].dailyContents[index].restGauge =
            charactersProvider.characters[characterIndex].dailyContents[index].restGauge - 20;
        charactersProvider.characters[characterIndex].dailyContents[index].saveRestGauge += 20;
      }
    } else if (charactersProvider.characters[characterIndex].dailyContents[index].maxClearNum ==
        charactersProvider.characters[characterIndex].dailyContents[index].clearNum) {
      charactersProvider.characters[characterIndex].dailyContents[index].clearNum = 0;
      charactersProvider.characters[characterIndex].dailyContents[index].restGauge +=
          charactersProvider.characters[characterIndex].dailyContents[index].saveRestGauge;
      charactersProvider.characters[characterIndex].dailyContents[index].saveRestGauge = 0;
    }
    notifyListeners();
  }

  // 캐릭터 추가
  void addCharacter(Character character) {
    charactersProvider.characters.add(character);
    notifyListeners();
  }

  // 캐릭터 삭제
  void removeCharacter(int index) {
    charactersProvider.characters.removeAt(index);
    notifyListeners();
  }

  void manualReset(BuildContext context) {
    DateTime nowDate = DateTime.now();
    Expedition expedition = Provider.of<ExpeditionProvider>(context, listen: false).expedition;
    expedition.nextWednesday = nowDate;
    List<Character> characterList = charactersProvider.characters;

    if (expedition.nextWednesday.weekday == 3) {
      expedition.nextWednesday = expedition.nextWednesday.add(Duration(days: 7));
    } else {
      while (expedition.nextWednesday.weekday != 3) {
        expedition.nextWednesday = expedition.nextWednesday.add(Duration(days: 1));
      }
    }
    expedition.list.forEach(
      (expeditionContent) {
        if (expeditionContent.type == "일일") {
          expeditionContent.clearCheck = false;
        }
        if (expeditionContent.type == "주간") {
          expeditionContent.clearCheck = false;
        }
      },
    );
    characterList.forEach((character) {
      character.dailyContents.forEach((dailyContent) {
        if (dailyContent is DailyContent) {
          dailyContent.clearChecked = false;
        }
      });
      character.weeklyContents.forEach((weeklyContent) {
        weeklyContent.clearChecked = false;
      });
      character.raidContents.forEach((raidContents) {
        raidContents.clearChecked = false;
        raidContents.clearGold = 0;
        raidContents.addGold = 0;
      });
    });
    Hive.box<User>('characters').put('user', User(characters: characterList));
    Hive.box<Expedition>('expedition').put('expeditionList', expedition);
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: "새로고침이 완료 되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        timeInSecForIosWeb: 2,
        fontSize: 14.0);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavigationScreen(
                  index: 1,
                )),
        (route) => false);
  }
}
