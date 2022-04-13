import 'package:adeline_project_dev/model/user/content/expedition_content.dart';
import 'package:flutter/cupertino.dart';

import 'expedition_model.dart';

class ExpeditionProvider extends ChangeNotifier {
  Expedition expedition = Expedition();

  void updateExpeditionContent(int index, ExpeditionContent expeditionContent) {
    expedition.list[index] = expeditionContent;
    notifyListeners();
  }

  void updateIsChecked(int index, bool value) {
    expedition.list[index].isChecked = value;
    notifyListeners();
  }

  void removeExpeditionContent(int index) {
    expedition.list.removeAt(index);
    notifyListeners();
  }

  void insertExpeditionContent(int newItemIndex, var movedItem2) {
    expedition.list.insert(newItemIndex, movedItem2);
    notifyListeners();
  }
}
