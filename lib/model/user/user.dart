import 'package:adeline_project_dev/model/user/expedition/expedition_model.dart';

import 'character/character_model.dart';

class User {
  List<Character> characters;
  Expedition expedition = Expedition();

  User({required this.characters});
}
