import 'package:adeline_project_dev/model/user/character/character_provider.dart';
import 'package:adeline_project_dev/model/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../constant/constant.dart';
import 'character/character_model.dart';
import 'content/gold_content.dart';

class UserProvider extends ChangeNotifier {
  CharacterProvider charactersProvider;

  final characterBox = Hive.box<User>('characters');

  int valTanNormal = 0;
  int valTanHard = 0;
  int biacKissNormal = 0;
  int biacKissHard = 0;
  int koukoSatonNormal = 0;
  int abrelshudNormal = 0;
  int abrelshudHard = 0;
  int argus = 0;
  int orehaNormal = 0;
  int orehaHard = 0;
  int totalGold = 0;

  UserProvider({required this.charactersProvider});

  void updateAddGold(int characterIndex, int index, int gold) {
    charactersProvider.characters[characterIndex].goldContents[index].addGold = gold;
    notifyListeners();
  }

  void goldContentsClearCheck(int characterIndex, int index, bool? value) {
    charactersProvider.characters[characterIndex].goldContents[index].clearChecked = value!;
    updateContentBoard();
    updateTotalGold();
    characterBox.put('user', User(characters: charactersProvider.characters));
    notifyListeners();
  }

  void updateTotalGold() {
    totalGold = 0;
    charactersProvider.characters.forEach((character) {
      character.goldContents.forEach((goldContent) {
        int level = int.parse(character.level);

        if (goldContent.isChecked && goldContent.clearChecked) {
          // 클리어 골드 획득 조건
          if (level < goldContent.getGoldLevelLimit && level > goldContent.enterLevelLimit) {
            if (goldContent.characterAlwaysMaxClear) {
              goldContent.goldPerPhase.forEach((element) => totalGold += element);
            } else {
              totalGold += goldContent.clearGold;
            }
          }
          // 추가 골드
          totalGold += goldContent.addGold;
        }
      });
    });
  }

  void updateContentBoard() {
     valTanNormal = 0;
     valTanHard = 0;
     biacKissNormal = 0;
     biacKissHard = 0;
     koukoSatonNormal = 0;
     abrelshudNormal = 0;
     abrelshudHard = 0;
     argus = 0;
     orehaNormal = 0;
     orehaHard = 0;
    for (int i = 0; i < charactersProvider.characters.length; i++) {
      for (int j = 0; j < charactersProvider.characters[i].goldContents.length; j++) {
        GoldContent goldContent = charactersProvider.characters[i].goldContents[j];
        switch (goldContent.name) {
          case "발탄":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              valTanNormal += 1;
            } else if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "하드") {
              valTanHard += 1;
            }
            break;
          case "비아키스":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              biacKissNormal += 1;
            } else if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "하드") {
              biacKissHard += 1;
            }
            break;
          case "쿠크세이튼":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              koukoSatonNormal += 1;
            }
            break;
          case "아브렐슈드":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              abrelshudNormal += 1;
            } else if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "하드") {
              abrelshudHard += 1;
            }
            break;
          case "아르고스":
            if (goldContent.isChecked && goldContent.clearChecked == false) {
              argus += 1;
            }
            break;
          case "오레하의 우물":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              orehaNormal += 1;
            } else if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "하드") {
              orehaHard += 1;
            }
        }
      }
    }
  }

  void providerSetState() {
    notifyListeners();
  }

  void initCharactersScreen() {
    characterBox.put('user', User(characters: charactersProvider.characters));
  }

  void dailyContentClearCheck(int characterIndex, int index, bool? value) {
    charactersProvider.characters[characterIndex].dailyContents[index].clearChecked = value!;
    characterBox.put('user', User(characters: charactersProvider.characters));
    notifyListeners();
  }

  void weeklyContentClearCheck(int characterIndex, int index, bool? value) {
    charactersProvider.characters[characterIndex].weeklyContents[index].clearChecked = value!;
    characterBox.put('user', User(characters: charactersProvider.characters));
    notifyListeners();
  }

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

  void addCharacter(Character character){
    charactersProvider.characters.add(character);
    notifyListeners();
  }
}
