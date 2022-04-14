import 'package:adeline_project_dev/model/user/character/character_provider.dart';
import 'package:adeline_project_dev/model/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../constant/constant.dart';
import 'content/gold_content.dart';

class UserProvider extends ChangeNotifier {
  CharacterProvider charactersProvider;
  final characterBox = Hive.box<User>('characters');

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
    totalGold.value = 0;
    charactersProvider.characters.forEach((character) {
      character.goldContents.forEach((goldContent) {
        int level = int.parse(character.level);

        if (goldContent.isChecked && goldContent.clearChecked) {
          // 클리어 골드 획득 조건
          if (level < goldContent.getGoldLevelLimit && level > goldContent.enterLevelLimit) {
            if (goldContent.characterAlwaysMaxClear) {
              goldContent.goldPerPhase.forEach((element) => totalGold.value += element);
            } else {
              totalGold.value += goldContent.clearGold;
            }
          }
          // 추가 골드
          totalGold.value += goldContent.addGold;
        }
      });
    });
  }

  void updateContentBoard() {
    valTanNormal.value = 0;
    valTanHard.value = 0;
    biacKissNormal.value = 0;
    biacKissHard.value = 0;
    koukoSatonNormal.value = 0;
    abrelshudNormal.value = 0;
    abrelshudHard.value = 0;
    argus.value = 0;
    orehaNormal.value = 0;
    orehaHard.value = 0;
    for (int i = 0; i < charactersProvider.characters.length; i++) {
      for (int j = 0; j < charactersProvider.characters[i].goldContents.length; j++) {
        GoldContent goldContent = charactersProvider.characters[i].goldContents[j];
        switch (goldContent.name) {
          case "발탄":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              valTanNormal.value += 1;
            } else if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "하드") {
              valTanHard.value += 1;
            }
            break;
          case "비아키스":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              biacKissNormal.value += 1;
            } else if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "하드") {
              biacKissHard.value += 1;
            }
            break;
          case "쿠크세이튼":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              koukoSatonNormal.value += 1;
            }
            break;
          case "아브렐슈드":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              abrelshudNormal.value += 1;
            } else if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "하드") {
              abrelshudHard.value += 1;
            }
            break;
          case "아르고스":
            argus.value += 1;
            break;
          case "오레하의 우물":
            if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "노말") {
              orehaNormal.value += 1;
            } else if (goldContent.isChecked && goldContent.clearChecked == false && goldContent.difficulty == "하드") {
              orehaHard.value += 1;
            }
        }
      }
    }
  }

  void providerSetState() {
    notifyListeners();
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
  void restGaugeContentClearCheck(int characterIndex, int index){
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
}
