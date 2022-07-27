import 'package:flutter/cupertino.dart';

import 'character_model.dart';

class CharacterProvider extends ChangeNotifier {
  List<Character> characters = [];

  set setCharacters(List<Character> list) => characters = list;
}
