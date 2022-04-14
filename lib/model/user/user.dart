import 'package:hive/hive.dart';

import 'character/character_model.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  List<Character> characters;

  User({required this.characters});
}
