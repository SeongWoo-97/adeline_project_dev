import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:flutter/material.dart';

class CharacterProfileProvider extends ChangeNotifier {
  CharacterProfile profile;

  CharacterProfileProvider({required this.profile});
}