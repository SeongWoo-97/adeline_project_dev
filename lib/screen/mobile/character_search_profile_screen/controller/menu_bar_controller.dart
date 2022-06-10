import 'package:flutter/cupertino.dart';

class MenuBarController extends ChangeNotifier {
  int tag = 0;
  List<String> options = ['장비', '스킬', '수집', '아바타'];

  void menuOnChanged(int value) {
    tag = value;
    notifyListeners();
  }
}
