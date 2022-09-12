import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/user/content/daily_content.dart';
import 'package:adeline_app/model/user/content/raid_content.dart';
import 'package:adeline_app/model/user/content/restGauge_content.dart';
import 'package:adeline_app/model/user/expedition/expedition_provider.dart';
import 'package:adeline_app/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'character/character_model.dart';
import 'character/character_provider.dart';
import 'expedition/expedition_model.dart';

class UserProvider extends ChangeNotifier {
  CharacterProvider charactersProvider;
  int selectedIndex = 0;

  final characterBox = Hive.box<User>(hiveUserName);
  final expeditionBox = Hive.box<Expedition>(hiveExpeditionName);

  ValueNotifier<int> totalGold = ValueNotifier<int>(0);

  UserProvider({required this.charactersProvider});

  @override
  void notifyListeners() {
    super.notifyListeners();
    characterBox.put('user', User(characters: charactersProvider.characters));
  }

  // 레이드 콘텐츠 추가골드
  void updateAddGold(int characterIndex, int index, int addGold,int minusGold) {
    charactersProvider.characters[characterIndex].raidContents[index].addGold = addGold;
    charactersProvider.characters[characterIndex].raidContents[index].minusGold = minusGold;
    notifyListeners();
  }

  // 레이드 콘텐츠 클리어 체크
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

  String weeklyGold(int characterIndex) {
    int clearGold = 0;
    int bonusGold = 0;
    // 한 캐릭터의 주간 골드
    charactersProvider.characters[characterIndex].raidContents.forEach((raidContent) {
      for (int i = 0; i < raidContent.clearList.length; i++) {
        if (raidContent.clearList[i].check) {
          if(expeditionBox.get('expeditionList')!.possibleGoldCharacters.contains(charactersProvider.characters[characterIndex].nickName)){
            clearGold += int.parse(raidContent.reward[raidContent.clearList[i].difficulty]!['클리어골드'][i].toString());
          }
          if (raidContent.bonusList[i].check) {
            bonusGold += int.parse(raidContent.reward[raidContent.bonusList[i].difficulty]!['더보기골드'][i].toString());
          }
        }
      }
      clearGold += raidContent.addGold - raidContent.minusGold;
    });
    charactersProvider.characters[characterIndex].totalGold = clearGold - bonusGold;
    return NumberFormat('###,###,###,###').format(clearGold - bonusGold);
  }

  // 전체 획득 골드
  int updateTotalGold() {
    totalGold = ValueNotifier<int>(0);
    charactersProvider.characters.forEach((character) {
      character.raidContents.forEach((raidContent) {
        int clearGold = 0;
        int bonusGold = 0;
        for (int i = 0; i < raidContent.clearList.length; i++) {
          if (raidContent.clearList[i].check) {
            if(expeditionBox.get('expeditionList')!.possibleGoldCharacters.contains(character.nickName)){
              clearGold += int.parse(raidContent.reward[raidContent.clearList[i].difficulty]!['클리어골드'][i].toString());
            }
            if (raidContent.bonusList[i].check) {
              bonusGold += int.parse(raidContent.reward[raidContent.bonusList[i].difficulty]!['더보기골드'][i].toString());
            }
          }
        }
        totalGold.value += clearGold + (raidContent.addGold - raidContent.minusGold) - bonusGold;
      });
    });
    return totalGold.value;
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
    expedition.nextWednesday = nowDate; // 현재시간으로 선언 후 현재시간 기준 가까운 수요일을 찾기 위해서
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
        if (dailyContent is RestGaugeContent) {
          dailyContent.clearNum = 0;
          dailyContent.restGauge = 0;
          dailyContent.saveRestGauge = 0;
          dailyContent.lateRevision = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);
          dailyContent.saveLateRevision = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);
        }
      });
      character.weeklyContents.forEach((weeklyContent) {
        weeklyContent.clearChecked = false;
      });
      character.raidContents.forEach((raidContent) {
        raidContent.clearList =
            List.generate(raidContent.totalPhase, (index) => CheckHistory(difficulty: raidContent.difficulty.first, check: false));
        raidContent.bonusList =
            List.generate(raidContent.totalPhase, (index) => CheckHistory(difficulty: raidContent.difficulty.first, check: false));
        raidContent.addGold = 0;
      });
    });
    Hive.box<User>(hiveUserName).put('user', User(characters: characterList));
    Hive.box<Expedition>(hiveExpeditionName).put('expeditionList', expedition);
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: "새로고침이 완료 되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        timeInSecForIosWeb: 2,
        fontSize: 14.0);
  }
}
