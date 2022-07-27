import 'package:adeline_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../content/expedition_content.dart';
import 'expedition_model.dart';

class ExpeditionProvider extends ChangeNotifier {
  Expedition expedition = Expedition();
  final expeditionBox = Hive.box<Expedition>(hiveExpeditionName);

  void updateExpeditionContent(int index, ExpeditionContent expeditionContent) {
    expedition.list[index] = expeditionContent;
    expeditionBox.put('expeditionList', expedition);

    notifyListeners();
  }

  void updateIsChecked(BuildContext context,int index, bool value) {
    expedition.list[index].isChecked = value;
    expeditionBox.put('expeditionList', expedition);

    notifyListeners();
  }

  void removeExpeditionContent(int index) {
    expedition.list.removeAt(index);
    expeditionBox.put('expeditionList', expedition);

    notifyListeners();
  }

  void insertExpeditionContent(int newItemIndex, var movedItem2) {
    expedition.list.insert(newItemIndex, movedItem2);
    expeditionBox.put('expeditionList', expedition);

    notifyListeners();
  }
  void updateClearCheck(BuildContext context,int index,bool value){
    expedition.list[index].clearCheck = value;
    expeditionBox.put('expeditionList', expedition);
    notifyListeners();
  }

  void addExpeditionContent(String contentType, String name, String iconName) {
    expedition.list.add(ExpeditionContent(contentType, name, iconName));
    expeditionBox.put('expeditionList', expedition);
    notifyListeners();
  }
}
