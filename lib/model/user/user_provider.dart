import 'package:adeline_project_dev/model/user/character/character_provider.dart';
import 'package:adeline_project_dev/model/user/expedition/expedition_provider.dart';
import 'package:flutter/cupertino.dart';


class UserProvider extends ChangeNotifier {
  CharacterProvider charactersProvider;
  ExpeditionProvider expeditionProvider = ExpeditionProvider();
  UserProvider({required this.charactersProvider});

  void updateAddGold(int characterIndex,int index,int gold) {
    charactersProvider.characters[characterIndex].goldContents[index].addGold = gold;
    notifyListeners();
  }

  void goldContentsClearCheck(int characterIndex,int index,bool? value) {
    charactersProvider.characters[characterIndex].goldContents[index].clearChecked = value;
    notifyListeners();
  }
}