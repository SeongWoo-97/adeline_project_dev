import 'package:flutter/cupertino.dart';

class MenuBarController extends ChangeNotifier {
  int tag = 0;
  PageController pageController = PageController();

  void menuOnChanged(int value) {
    tag = value;
    notifyListeners();
  }
}

class CollectionMenuBarController extends ChangeNotifier {
  int tag = 0;
  PageController pageController = PageController();

  void menuOnChanged(int value) {
    tag = value;
    notifyListeners();
  }
}
