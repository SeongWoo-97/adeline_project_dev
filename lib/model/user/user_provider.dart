import 'package:adeline_project_dev/model/user/character/character_provider.dart';
import 'package:adeline_project_dev/model/user/expedition/expedition_provider.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/constant.dart';
import 'content/gold_content.dart';

class UserProvider extends ChangeNotifier {
  CharacterProvider charactersProvider;
  ExpeditionProvider expeditionProvider = ExpeditionProvider();

  UserProvider({required this.charactersProvider});

  void updateAddGold(int characterIndex, int index, int gold) {
    charactersProvider.characters[characterIndex].goldContents[index].addGold = gold;
    notifyListeners();
  }

  void goldContentsClearCheck(int characterIndex, int index, bool? value) {
    charactersProvider.characters[characterIndex].goldContents[index].clearChecked = value!;
    updateContentBoard();
    notifyListeners();
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
    print('하이2');
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
}
